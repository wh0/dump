#!/bin/sh -eu
find "$@" \
  \( -type d -printf 'mkdir %p\n' \) -o \
  \( -type l -printf 'ln -s %l %p\n' \) -o \
  \( -type f \
    -printf "cat >%p <<'DUMP_EOF'\n" \
    -exec cat {} \; \
    -printf 'DUMP_EOF\n' \
    \( ! -executable -o -printf 'chmod +x %p\n' \) \) -o \
  -fprintf /dev/stderr 'unable to dump %p\n'
