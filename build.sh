#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SIM86_DIR="$SCRIPT_DIR/sim86"
BUILD_DIR="$SCRIPT_DIR/build"

mkdir -p "$SIM86_DIR/shared"
mkdir -p "$BUILD_DIR"

pushd "$BUILD_DIR"

clang -g "$SIM86_DIR/sim86.cpp" \
    -o sim86

#clang -O3 -g "$SIM86_DIR/sim86.cpp" \
#    -o sim86

#clang -P -E "$SIM86_DIR/sim86_lib.h" \
#    | clang-format --style="Microsoft" \
#    > "$SIM86_DIR/shared/sim86_shared.h"

#clang -P -E "$SIM86_DIR/sim86_instruction_table_standalone.h" \
#    | clang-format --style="Microsoft" \
#    > "$SIM86_DIR/shared/sim86_instruction_table_standalone.h"

#clang -dynamiclib -g "$SIM86_DIR/sim86_lib.cpp" \
#    -install_name @rpath/libsim86_shared_debug.dylib \
#    -o "$SIM86_DIR/shared/libsim86_shared_debug.dylib"
#
#clang -dynamiclib -O3 -g "$SIM86_DIR/sim86_lib.cpp" \
#    -install_name @rpath/libsim86_shared_release.dylib \
#    -o "$SIM86_DIR/shared/libsim86_shared_release.dylib"
#
#clang -g "$SIM86_DIR/shared/shared_library_test.cpp" \
#    -L"$SIM86_DIR/shared" \
#    -lsim86_shared_debug \
#    -Wl,-rpath,@loader_path/../shared \
#    -o shared_library_test

popd