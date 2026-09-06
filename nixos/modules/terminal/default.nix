{ inputs, lib, ... }:

{
  imports = [
    (inputs.import-tree.filterNot (lib.hasSuffix "default.nix") ./.)
  ];
}
