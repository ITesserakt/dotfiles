# A funny way to get prime numbers
def "math primes" [
  up_to: int
] {
  2..$up_to |
  	each {|it| '1' | fill -c '1' -w $it } | 
  	find -r '^1?$|^(11+?)\1+$' --invert | 
  	each {|it| $it | str length }
}

# Finds all nix store paths containing given name and calculates their size
def "nix store du" [
	name: string,
	--total_size (-t)
] {
	let result = ls /nix/store | where type == 'dir' | where name =~ $name | get name | each {|it| du $it | first}
	if $total_size {
		$result | math sum
	} else {
		$result
	}
}

def "ldd" [
	name: string
] {
	^ldd $name 
		| lines 
		| parse "{lib} => {path}" 
}

def --wrapped "zfs list" [
	...args
] {
	^zfs list ...$args
		| from ssv 
		| each {|it| 
			{ NAME: $it.NAME, 
			  USED: ($it.USED | into filesize), 
			  AVAIL: ($it.AVAIL | into filesize), 
			  REFER: ($it.REFER | into filesize), 
			  MOUNTPOINT: $it.MOUNTPOINT } 
		  }
}
