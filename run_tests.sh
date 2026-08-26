#!/usr/bin/env bash
# Local test runner for "SQL Intermediate" (shipthatcode.com).
# Usage:
#   ./run_tests.sh        run every lesson's tests
#   ./run_tests.sh 03     run only tests/03-*'s tests
set -u
LANG_SLUG="sql"
ENTRY="main.sql"
FILTER="${1:-}"
# Test dirs are zero-padded (01-, 02-, …) — accept "./run_tests.sh 3" too.
case "$FILTER" in [1-9]) FILTER="0$FILTER" ;; esac

# Languages the grader supports but this local runner can't fake reliably
# yet. The website's Check is the official grade either way.
case "$LANG_SLUG" in
  sql|prolog)
    echo "The local runner doesn't support $LANG_SLUG yet."
    echo "Write your code here, push, and grade with 'Check my solution' on the lesson page."
    exit 2 ;;
esac

# Prefer gcc/g++ (Linux, MinGW on Windows) but fall back to cc/c++ (macOS).
CC_BIN=cc;  command -v gcc >/dev/null 2>&1 && CC_BIN=gcc
CXX_BIN=c++; command -v g++ >/dev/null 2>&1 && CXX_BIN=g++
# Windows installs often have "python", not "python3".
PY_BIN=python3; command -v python3 >/dev/null 2>&1 || PY_BIN=python

compile() {
  case "$LANG_SLUG" in
    c)        "$CC_BIN" -O2 -o .prog "$ENTRY" ;;
    cpp)      "$CXX_BIN" -std=c++17 -O2 -o .prog "$ENTRY" ;;
    rust)     rustc -O -o .prog "$ENTRY" ;;
    java)     javac "$ENTRY" ;;
    assembly) nasm -felf64 "$ENTRY" -o .prog.o && ld .prog.o -o .prog ;;
    basic)    fbc -x .prog "$ENTRY" ;;
    cobol)    cobc -xF -o .prog "$ENTRY" ;;
    csharp)   mcs -out:.prog.exe "$ENTRY" ;;
    d)        dmd -of=.prog "$ENTRY" ;;
    fortran)  gfortran -O2 -o .prog "$ENTRY" ;;
    kotlin)   kotlinc "$ENTRY" -include-runtime -d .prog.jar ;;
    objc)
      if [ "$(uname)" = "Darwin" ]; then
        "$CC_BIN" -framework Foundation -o .prog "$ENTRY"
      else
        "$CC_BIN" -o .prog "$ENTRY"
      fi ;;
    pascal)   fpc -o.prog "$ENTRY" > /dev/null ;;
    vbnet)    vbnc -out:.prog.exe "$ENTRY" ;;
    *)        return 0 ;;
  esac
}

run_one() { # $1 = input file
  case "$LANG_SLUG" in
    c|cpp|rust|assembly|basic|cobol|d|fortran|pascal) ./.prog < "$1" ;;
    csharp|vbnet) mono .prog.exe < "$1" ;;
    kotlin)     java -jar .prog.jar < "$1" ;;
    python)     "$PY_BIN" "$ENTRY" < "$1" ;;
    javascript) node "$ENTRY" < "$1" ;;
    typescript) npx -y tsx "$ENTRY" < "$1" ;;
    go)         go run "$ENTRY" < "$1" ;;
    java)       java "${ENTRY%.java}" < "$1" ;;
    bash)       bash "$ENTRY" < "$1" ;;
    clojure)    clojure -M "$ENTRY" < "$1" ;;
    elixir)     elixir "$ENTRY" < "$1" ;;
    erlang)     escript "$ENTRY" < "$1" ;;
    fsharp)     dotnet fsi "$ENTRY" < "$1" ;;
    groovy)     groovy "$ENTRY" < "$1" ;;
    haskell)    runghc "$ENTRY" < "$1" ;;
    lisp)       sbcl --script "$ENTRY" < "$1" ;;
    lua)        lua "$ENTRY" < "$1" ;;
    objc)       ./.prog < "$1" ;;
    ocaml)      ocaml "$ENTRY" < "$1" ;;
    octave)     octave -qf "$ENTRY" < "$1" ;;
    perl)       perl "$ENTRY" < "$1" ;;
    php)        php "$ENTRY" < "$1" ;;
    r)          Rscript "$ENTRY" < "$1" ;;
    ruby)       ruby "$ENTRY" < "$1" ;;
    scala)      scala "$ENTRY" < "$1" ;;
    swift)      swift "$ENTRY" < "$1" ;;
    *)          echo "unsupported language: $LANG_SLUG" >&2; exit 1 ;;
  esac
}

if ! compile; then
  echo "COMPILE FAILED"
  exit 1
fi

pass=0; fail=0
for dir in tests/${FILTER}*/; do
  [ -d "$dir" ] || continue
  for input in "$dir"*.in; do
    [ -f "$input" ] || continue
    expected="${input%.in}.out"
    actual="$(run_one "$input")"
    if [ "$actual" = "$(cat "$expected")" ]; then
      pass=$((pass+1)); echo "PASS  $input"
    else
      fail=$((fail+1)); echo "FAIL  $input"
      echo "  expected: $(head -c 200 "$expected")"
      echo "  got:      $(printf '%s' "$actual" | head -c 200)"
    fi
  done
done

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
