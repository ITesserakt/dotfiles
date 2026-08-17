{ self, ... }: {
  flake.homeModules.noctalia_wallhaven = self.meta.mkNoctaliaPlugin {
    name = "wallhaven";
  };
}
