This is a reproducer for https://github.com/NixOS/nixpkgs/issues/289505.

How to reproduce (on NixOS):

1. nix develop
2. bazel build //:my-rule

`PATH` during rule evalulation is `/no-such-path`.
