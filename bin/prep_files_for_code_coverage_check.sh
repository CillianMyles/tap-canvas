#!/bin/sh

# Reference https://github.com/flutter/flutter/issues/27997#issuecomment-587536884
# Reference https://unix.stackexchange.com/a/47235
# Reference https://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself/4774063
# Reference https://unix.stackexchange.com/a/479353

file=test/coverage_helper_test.dart
echo "// Helper file to make coverage work for all dart files\n" > $file
echo "// ignore_for_file: unused_import" >> $file
find lib -name '*.dart' | cut -c4- | awk -v package=$1 '{printf "import '\''package:%s%s'\'';\n", package, $1}' >> $file
echo "void main(){}" >> $file
