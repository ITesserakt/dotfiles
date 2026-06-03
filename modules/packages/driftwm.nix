{
  perSystem =
    { pkgs, system, ... }:
    let
      nativeBuildInputs = with pkgs; [
        pkg-config
      ];

      buildInputs = with pkgs; [
        wayland
        wayland-protocols
        seatd # libseat
        libdisplay-info
        libinput
        libgbm
        libxkbcommon
        libdrm
        systemd # libudev
        libglvnd
        libx11
        libxcursor
        libxrandr
        libxi
        libxcb
        pixman
      ];

      runtimeLibs = with pkgs; [
        wayland
        seatd
        libdisplay-info
        libinput
        libgbm
        libxkbcommon
        libdrm
        systemd
        libglvnd
        libx11
        libxcursor
        libxrandr
        libxi
        libxcb
        pixman
      ];

      src = pkgs.fetchFromGitHub {
        repo = "driftwm";
        owner = "malbiruk";
        rev = "v0.9.0";
        sha256 = "sha256-gRNNZhK/jl4GKATMjAHPZ72BFEmAuxAV/s3+SdVkdyw=";
      };
    in
    {
      packages.driftwm = pkgs.rustPlatform.buildRustPackage {
        pname = "driftwm";
        version = (fromTOML (builtins.readFile "${src}/Cargo.toml")).package.version;

        src = pkgs.lib.cleanSourceWith {
          inherit src;
          filter =
            path: type:
            let
              basename = baseNameOf path;
            in
            basename != "target" && basename != ".git" && basename != ".direnv";
        };

        cargoLock = {
          lockFile = "${src}/Cargo.lock";
          allowBuiltinFetchGit = true;
        };

        inherit nativeBuildInputs buildInputs;

        # Make sure the binary can find shared libraries at runtime
        postFixup = ''
          patchelf --add-rpath "${pkgs.lib.makeLibraryPath runtimeLibs}" $out/bin/driftwm
        '';

        postInstall = ''
          install -Dm755 resources/driftwm-session $out/bin/driftwm-session
          install -Dm644 resources/driftwm.desktop $out/share/wayland-sessions/driftwm.desktop
          install -Dm644 resources/driftwm-portals.conf $out/share/xdg-desktop-portal/driftwm-portals.conf
          install -Dm644 resources/driftwm.service $out/lib/systemd/user/driftwm.service
          install -Dm644 resources/driftwm-shutdown.target $out/lib/systemd/user/driftwm-shutdown.target
          install -Dm644 config.reference.toml $out/etc/driftwm/config.reference.toml
          for f in extras/wallpapers/*.glsl; do
            install -Dm644 "$f" "$out/share/driftwm/wallpapers/$(basename "$f")"
          done

          substituteInPlace $out/share/wayland-sessions/driftwm.desktop --replace-fail "Exec=driftwm-session" "Exec=$out/bin/driftwm-session"

          substituteInPlace $out/lib/systemd/user/driftwm.service --replace-fail "ExecStart=driftwm" "ExecStart=$out/bin/driftwm"
        '';

        passthru.providedSessions = [ "driftwm" ];

        meta = with pkgs.lib; {
          description = "A trackpad-first infinite canvas Wayland compositor";
          license = licenses.gpl3Plus;
          platforms = [ system ];
          mainProgram = "driftwm";
        };
      };
    };
}
