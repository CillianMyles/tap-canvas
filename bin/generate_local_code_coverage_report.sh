#!/bin/bash

# Ensure lcov is installed
if ! command -v COMMAND &> /dev/null
then
    echo "Error! lcov could not be found!"
    echo "brew install lcov"
    exit
fi

# Ensure code coverage checks correct files
chmod +x bin/prep_files_for_code_coverage_check.sh
sh bin/prep_files_for_code_coverage_check.sh tap_canvas

# Run the tests (with coverage)
flutter test --coverage

# Convert coverage report to html page
genhtml coverage/lcov.info -o coverage/html
