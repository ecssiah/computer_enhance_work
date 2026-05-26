#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$SCRIPT_DIR/build"
SIM86_DIR="$SCRIPT_DIR/sim86"
SHARED_DIR="$SCRIPT_DIR/sim86/shared"

mkdir -p "$BUILD_DIR"
mkdir -p "$SHARED_DIR"

pushd "$BUILD_DIR"

clang -g "$SIM86_DIR/sim86.cpp" \
    -o sim86_clang_debug

clang -O3 -g "$SIM86_DIR/sim86.cpp" \
    -o sim86_clang_release

clang -P -E "$SIM86_DIR/sim86_lib.h" \
    | clang-format --style="Microsoft" \
    > "$SHARED_DIR/sim86_shared.h"

clang -P -E "$SIM86_DIR/sim86_instruction_table_standalone.h" \
    | clang-format --style="Microsoft" \
    > "$SHARED_DIR/sim86_instruction_table_standalone.h"

clang -dynamiclib -g "$SIM86_DIR/sim86_lib.cpp" \
    -install_name @rpath/libsim86_shared_debug.dylib \
    -o "$SHARED_DIR/libsim86_shared_debug.dylib"

clang -dynamiclib -O3 -g "$SIM86_DIR/sim86_lib.cpp" \
    -install_name @rpath/libsim86_shared_release.dylib \
    -o "$SHARED_DIR/libsim86_shared_release.dylib"

clang -g "$SHARED_DIR/shared_library_test.cpp" \
    -L"$SHARED_DIR" \
    -lsim86_shared_debug \
    -Wl,-rpath,@loader_path/../shared \
    -o shared_library_test

popd