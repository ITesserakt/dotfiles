let
  contourVersion = "0.6.2";
  boxedVersion = "1.4.3";
  termbenchproVersion = "f6c37988e6481b48a8b8acaf1575495e018e9747";
  reflection_cppVersion = "02484cd9ec16d7efc252ab8fd1f85d7264192418";
in
{ self, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      boxed-source = pkgs.fetchFromGitHub {
        owner = "contour-terminal";
        repo = "boxed-cpp";
        rev = "v${boxedVersion}";
        sha256 = "sha256-uZ/wT159UuEcTUtoQyt0D59z2wnLT5KpeeCpjyij198=";
      };
      termbenchpro-source = pkgs.fetchFromGitHub {
        owner = "contour-terminal";
        repo = "termbench-pro";
        rev = termbenchproVersion;
        sha256 = "sha256-Yyvlu/yx/yGc9Ci9Pn098YfTdywLZEaowQZeLM4WGjQ=";
      };
      reflection_cpp-source = pkgs.fetchFromGitHub {
        owner = "contour-terminal";
        repo = "reflection-cpp";
        rev = reflection_cppVersion;
        sha256 = "sha256-Y00lQZTtaRfBsB6+40Ot+WFFlwemri0d3hLkU9kkEo4=";
      };
      glaze-source = pkgs.fetchFromGitHub {
        owner = "stephenberry";
        repo = "glaze";
        rev = "v3.4.2";
        sha256 = "sha256-zMKIDxVorhTiSKjIJ+d/WgSw2bdG3qbDZg88wLNamlE=";
      };
      specificQtNixpkgs = pkgs.fetchFromGitHub {
        owner = "nixos";
        repo = "nixpkgs";
        rev = "c80f6a7e10b39afcc1894e02ef785b1ad0b0d7e5";
        sha256 = "sha256-C7jVfohcGzdZRF6DO+ybyG/sqpo1h6bZi9T56sxLy+k=";
      };
      specificQtPkgs = import specificQtNixpkgs {
        inherit (pkgs.stdenv.hostPlatform) system;
      };
      cmakePreset =
        if pkgs.stdenv.isLinux then
          "linux-release"
        else if pkgs.stdenv.isDarwin then
          "macos-release"
        else
          throw "Unsupported system: ${pkgs.stdenv.hostPlatform.system}";
    in
    {
      packages.contour-source = pkgs.stdenv.mkDerivation {
        pname = "contour-source";
        version = contourVersion;

        src = pkgs.fetchFromGitHub {
          owner = "contour-terminal";
          repo = "contour";
          rev = "0aca498d250507ade3935f9139dc1ca814091fb8";
          sha256 = "sha256-oZXY544HnjV4G5HCQYdMmg1UIIi/N3A5bwCN+2Jd2jM=";
        };

        configurePhase = "mkdir -p $out/_deps/sources";

        installPhase =
          let
            extra_src_dir = "$out/_deps/sources";
            cmake_file = "$out/_deps/sources/CMakeLists.txt";
          in
          ''
                    runHook preInstall

                    cp -r $src/* $out/

                    ln -s ${boxed-source} ${extra_src_dir}/boxed-cpp-${boxedVersion}
            	  	  echo "macro(ContourThirdParties_Embed_boxed_cpp)" >> ${cmake_file}
                    echo "    add_subdirectory(\''${ContourThirdParties_SRCDIR}/boxed-cpp-${boxedVersion} EXCLUDE_FROM_ALL)" >> ${cmake_file}
                    echo "endmacro()" >> ${cmake_file}

                    ln -s ${termbenchpro-source} ${extra_src_dir}/termbench-pro-${termbenchproVersion}
                    echo "macro(ContourThirdParties_Embed_termbench_pro)" >> ${cmake_file}
                    echo "    add_subdirectory(\''${ContourThirdParties_SRCDIR}/termbench-pro-${termbenchproVersion} EXCLUDE_FROM_ALL)" >> ${cmake_file}
                    echo "endmacro()" >> ${cmake_file}

              		  ln -s ${reflection_cpp-source} ${extra_src_dir}/reflection-cpp-${reflection_cppVersion}
                    echo "macro(ContourThirdParties_Embed_reflection_cpp)" >> ${cmake_file}
                    echo "    add_subdirectory(\''${ContourThirdParties_SRCDIR}/reflection-cpp-${reflection_cppVersion} EXCLUDE_FROM_ALL)" >> ${cmake_file}
                    echo "endmacro()" >> ${cmake_file}


                    runHook postInstall
          '';
      };

      packages.contour = pkgs.clangStdenv.mkDerivation {
        pname = "contour";
        version = contourVersion;

        src = self.packages.${pkgs.stdenv.hostPlatform.system}.contour-source;
        outputs = [
          "out"
          "terminfo"
        ];

        nativeBuildInputs = with pkgs; [
          cmake
          extra-cmake-modules
          fontconfig
          ninja
          pkg-config
          ncurses
          fmt
          installShellFiles
        ];

        buildInputs =
          with pkgs;
          [
            microsoft-gsl
            range-v3
            libutempter
            yaml-cpp
            libunicode
            harfbuzz
            libssh2
            libxcb
          ]
          ++ (with specificQtPkgs.kdePackages; [
            qt5compat
            qtbase
            wrapQtAppsHook
            qtwayland
            qtmultimedia
            qtdeclarative
          ]);

        configurePhase = ''
          runHook preConfigure

          cmake --preset ${cmakePreset} -DCMAKE_INSTALL_PREFIX=$out -DFETCHCONTENT_SOURCE_DIR_GLAZE=${glaze-source} -DCONTOUR_TESTING=OFF

          runHook postConfigure
        '';

        buildPhase = ''
          runHook preBuild

          cmake --build --preset ${cmakePreset}

          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall

          cmake --build --preset ${cmakePreset} --target install

          runHook postInstall
        '';

        postInstall = ''
          mkdir -p $out/nix-support $terminfo/share
          mv $out/share/terminfo $terminfo/share/

          installShellCompletion --zsh $out/share/contour/shell-integration/shell-integration.zsh
          installShellCompletion --fish $out/share/contour/shell-integration/shell-integration.fish
          installShellCompletion --bash $out/share/contour/shell-integration/shell-integration.bash

          echo "$terminfo" >> $out/nix-support/propagated-user-env-packages
        '';
      };
    };
}
