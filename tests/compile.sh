#!/bin/bash

find /tests -name "*.tex" -print0 | while IFS= read -r -d "" file; do
  cd "$(dirname "$file")" && echo "compiling inside $(pwd)" && latexmk -r /tests/latexmkrc "$(basename "$file")" || exit 1
done || exit 1
