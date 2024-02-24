#!/usr/bin/env bash

# (The absolute path to the program is provided as the first and only argument.)
CALCULATOR=$1

echo "We've set up a GitHub Actions Workflow that will run all"
echo "of the shell scripts in this directory as a series of tests."
echo
echo "To fail any test, you should use the exit 1 command;"
echo "To end a test early as a success, you should use the exit 0 command."

echo "Invoke your program with the \$CALCULATOR variable; an example is below"


# Test 01: Ensure the program runs without error with a simple, valid invocation.
if ! $CALCULATOR 1 + 1; then  # If the return code of $PROGRAM is non-zero (i.e. error)...
  echo 'ERROR! A valid run of the calculator (1 + 1) failed!'
  exit 1
fi

# Test 02: Ensure simple case has correct output...
if [[ $($CALCULATOR 1 + 1) -ne 2 ]]; then  # If the output of the program is not 2...
  echo 'ERROR! A valid run of the calculator (1 + 1) failed to produce 2 as an output!'
  exit 1
fi

# Test 03: Ensure program errors with an invalid operand
if $CALCULATOR 3 @ 2; then  # If the return code of $PROGRAM is zero (i.e. success)...
  echo 'ERROR! An invalid run of the application (3 @ 2) apparently succeeded?!'
  exit 1
fi

if [[ $($CALCULATOR 5 - 3) -ne 2 ]]; then
  echo 'ERROR! Subtraction test (5 - 3) failed to produce 2!'
  exit 1
fi

# Test multiplication
if [[ $($CALCULATOR 2 '*' 3) -ne 6 ]]; then  # Note: '*' must be quoted
  echo 'ERROR! Multiplication test (2 * 3) failed to produce 6!'
  exit 1
fi

# Test division
if [[ $($CALCULATOR 6 / 2) -ne 3 ]]; then
  echo 'ERROR! Division test (6 / 2) failed to produce 3!'
  exit 1
fi

# Test division by zero - expecting error or specific output
if $CALCULATOR 1 / 0; then
  echo 'ERROR! Division by zero should fail!'
  exit 1
fi

# Test quiet mode with valid operation
if ! output=$($CALCULATOR -q 1 + 1); then
  echo 'ERROR! Quiet mode operation (1 + 1) failed!'
  exit 1
elif [[ $output -ne 2 ]]; then
  echo 'ERROR! Quiet mode operation (1 + 1) failed to produce correct output!'
  exit 1
fi

# Test with non-numeric input
if $CALCULATOR a + b; then
  echo 'ERROR! Non-numeric input should fail!'
  exit 1
fi

echo "All tests passed successfully."
exit 0