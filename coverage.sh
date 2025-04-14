#!/bin/bash

# Ensure we have lcov installed
command -v lcov >/dev/null 2>&1 || { echo "lcov is required but not installed. Install it using 'brew install lcov' on macOS or 'sudo apt-get install lcov' on Ubuntu."; exit 1; }

# Clean previous coverage data
rm -rf coverage
flutter test --coverage

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# Open the report in the default browser
if [[ "$OSTYPE" == "darwin"* ]]; then
  open coverage/html/index.html
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  xdg-open coverage/html/index.html
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
  start coverage/html/index.html
else
  echo "Report generated at coverage/html/index.html"
fi

echo "Coverage report generated successfully!" 