@echo off
echo Running tests with coverage...

:: Clean previous coverage data
if exist coverage rmdir /s /q coverage

:: Run tests with coverage
flutter test --coverage

:: Check if lcov is installed
where lcov >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo LCOV is not installed or not in PATH. Coverage report will not be generated.
    echo To install LCOV on Windows, use Chocolatey: choco install lcov
    echo Or download from: http://gnuwin32.sourceforge.net/packages/lcov.htm
    exit /b
)

:: Generate HTML report
genhtml coverage\lcov.info -o coverage\html

:: Open the report in the default browser
start coverage\html\index.html

echo Coverage report generated successfully! 