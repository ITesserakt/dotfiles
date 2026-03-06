{
  flake.nixosModules.ssh = {
    programs.openssh.enable = true;
  };
}
