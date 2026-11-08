{
  flake.modules.darwin.rift = {
    homebrew.brews = [{
      name = "acsandmann/tap/rift";
      restart_service = "changed";
      postinstall = ''rift service install'';
    }];
  };
}
