{
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        riscv-toolchain =
          import nixpkgs {
            localSystem = "${system}";
            crossSystem = {
              #config = "riscv64-none-elf";
              config = "riscv64-unknown-none-elf";
            };
          };
      in
        with import <nixpkgs> {};
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              riscv-toolchain.buildPackages.gcc
              openocd
              mkspiffs-presets.esp-idf              
            ];
          };
        }
    );
}
