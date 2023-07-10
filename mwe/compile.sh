#!/bin/bash

find /mwe -name "*.tex" -print0 | while IFS= read -r -d "" file; do
  cd "$(dirname "$file")" && echo "compiling inside $(pwd)" && latexmk -r /mwe/latexmkrc "$(basename "$file")" -silent || exit 1
done || exit 1
