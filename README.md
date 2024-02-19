This is a reproducer for https://github.com/NixOS/nixpkgs/issues/289505.

How to reproduce (on NixOS):

1. nix develop
2. bazel build //:my-rule

`PATH` during rule evalulation is `/no-such-path`.

See also this gist containing an strace log: https://gist.githubusercontent.com/malt3/27d8022a31a0525700623591cfca87e0/raw/028720745e6a96e4c7e9a87c63b6f85dd8e62694/strace.log
(Search for the pid 532284)
