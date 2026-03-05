let fish_completer = {|spans|
	fish --command $'complete "--do-complete=($spans | str join " ")"' 
	| $"value(char tab)description(char newline)" + $in 
	| from tsv --flexible --no-infer
}

let carapace_completer = {|spans: list<string>|
  carapace $spans.0 nushell ...$spans
  | from json
  | if ($in | default [] | where value =~ '^.*ERR$' | is-empty) { $in }
}

let zoxide_completer = {|spans|
 	let zoxide_output = $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD }
   	if ($zoxide_output | is-empty) {
   		# forward to carapace if zoxide failed
   		$fish_completer | do $in $spans
   	} else {
   		$zoxide_output 
   	}
}

let external_completer = {|spans|
 	let expanded_alias = scope aliases 
 	| where name == $spans.0 
 	| get -o 0.expansion

  let spans  = if $expanded_alias != null {
  	$spans | skip 1 | prepend ($expanded_alias | split row ' ' | take 1)
  } else {
    $spans
  }
	# remove sudo and complete the rest
	let spans = if $spans.0 == sudo { $spans | skip 1 } else { $spans }

  match $spans.0 {
  	# Specify commands here that does not have carapace completions
  	__zoxide_z | __zoxide_zi => $zoxide_completer
  	_ => $carapace_completer
  } | do $in $spans
}
