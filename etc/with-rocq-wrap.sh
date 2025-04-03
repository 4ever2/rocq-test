#!/usr/bin/env bash

set -ex

rocq=$(command -v rocq)
# NB on cygwin "$rocq" is a cygwin path (/foo/bar)
# but reading files from hash.exe needs windows paths (C:/cygwin/foo/bar)
# we avoid the problem by going through stdin
rocqhash=$(dune exec --root "$(dirname "$0")"/.. -- etc/tools/hash.exe < "$rocq")

rm -rf .wrappers
mkdir .wrappers

cat > .wrappers/coqc <<EOF
#!/bin/sh
# hash = $rocqhash
exec rocq c "\$@"
EOF

cat > .wrappers/coqdep <<EOF
#!/bin/sh
# hash = $rocqhash
exec rocq dep "\$@"
EOF

cat > .wrappers/coqdoc <<EOF
#!/bin/sh
# hash = $rocqhash
exec rocq doc "\$@"
EOF

cat > .wrappers/coqpp <<EOF
#!/bin/sh
# hash = $rocqhash
exec rocq pp-mlg "\$@"
EOF

chmod +x .wrappers/coqc .wrappers/coqdep .wrappers/coqdoc .wrappers/coqpp



export PATH="$PWD/.wrappers:$PATH"
export OCAMLPATH="$PWD/.wrappers:$OCAMLPATH"

"$@"
