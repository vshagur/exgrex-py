#!/usr/bin/env bats

# set grader name
GRADER="grader_f"

setup() {
  CWD="$PWD"
  REPORT="$PWD/TestGraders/$GRADER/shared/feedback.json"
  COMMAND="$(dirname $PWD)/.env/bin/exgrexCoursera2Py"
  cd "TestGraders/$GRADER"
}

teardown() {
  cd "$CWD"
}


@test "check output tests failed (failfast=False, traceback=True, verbosity=2)" {
  PART_ID="ABCD"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  #  check score string
  [ ${lines[1]} = '  "fractionalScore": "0.44",' ]
  # check title
  run bash -c "grep -E \".*feedback.*Test result of the task.*Example task.*Attempt at.*\" $REPORT"
  [ "$status" = 0 ]
  #  check descriptions
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_1. short description for test_1\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_4. short description for test_4\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_5. short description for test_5\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_7. short description for test_7\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[FAILED\] test_summa.TestSumma.test_2. short description for test_2\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[ERROR\] test_summa.TestSumma.test_3. short description for test_3\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[FAILED\] test_summa.TestSumma.test_6 \(i=4\). short description for test_6\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[ERROR\] test_summa.TestSumma.test_6_1 \(i=0\). short description for test_6_1\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[FAILED\] test_summa.TestSumma.test_8. short description for test_8\" $REPORT"
  [ "$status" = 0 ]
  #  check result message
  run bash -c "grep -E  \"Not passed. Score: 44 points out of 100.\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"To pass the test, you need to score 60 points.\" $REPORT"
  [ "$status" = 0 ]
  # check traceback
  run bash -c "grep -E  \"Lists differ: \[1, 2, 3, 4, 5\] != \[9, 10\]\" $REPORT"
  [ "$status" = 0 ]
  # check assert message
  run bash -c "grep -E  \"msg for test_2\" $REPORT"
  [ "$status" = 0 ]
}

@test "check output tests failed (failfast=True, traceback=True, verbosity=2)" {
  PART_ID="ABCE"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  #  check score string
  [ ${lines[1]} = '  "fractionalScore": "0",' ]
  # check title
  run bash -c "grep -E \".*feedback.*Test result of the task.*Example task.*Attempt at.*\" $REPORT"
  [ "$status" = 0 ]
  #  check descriptions
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_1. short description for test_1\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_4. short description for test_4\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_5. short description for test_5\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_7. short description for test_7\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[FAILED\] test_summa.TestSumma.test_2. short description for test_2\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[ERROR\] test_summa.TestSumma.test_3. short description for test_3\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[FAILED\] test_summa.TestSumma.test_6 \(i=4\). short description for test_6\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[ERROR\] test_summa.TestSumma.test_6_1 \(i=0\). short description for test_6_1\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[FAILED\] test_summa.TestSumma.test_8. short description for test_8\" $REPORT"
  [ "$status" = 1 ]
  #  check result message
  run bash -c "grep -E  \"Not passed. Try again.\" $REPORT"
  [ "$status" = 0 ]
  # check traceback
  run bash -c "grep -E  \"Lists differ: \[1, 2, 3, 4, 5\] != \[9, 10\]\" $REPORT"
  [ "$status" = 0 ]
  # check assert message
  run bash -c "grep -E  \"msg for test_2\" $REPORT"
  [ "$status" = 0 ]
}

@test "check output tests failed (failfast=True, traceback=True, verbosity=1)" {
  PART_ID="ABCF"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  #  check score string
  [ ${lines[1]} = '  "fractionalScore": "0",' ]
  # check title
  run bash -c "grep -E \".*feedback.*Test result of the task.*Example task.*Attempt at.*\" $REPORT"
  [ "$status" = 0 ]
  #  check descriptions
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_1. short description for test_1\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_4. short description for test_4\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_5. short description for test_5\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_7. short description for test_7\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[FAILED\] test_summa.TestSumma.test_2. short description for test_2\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[ERROR\] test_summa.TestSumma.test_3. short description for test_3\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[FAILED\] test_summa.TestSumma.test_6 \(i=4\). short description for test_6\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[ERROR\] test_summa.TestSumma.test_6_1 \(i=0\). short description for test_6_1\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[FAILED\] test_summa.TestSumma.test_8. short description for test_8\" $REPORT"
  [ "$status" = 1 ]
  #  check result message
  run bash -c "grep -E  \"Not passed. Try again.\" $REPORT"
  [ "$status" = 0 ]
  # check traceback
  run bash -c "grep -E  \"Lists differ: \[1, 2, 3, 4, 5\] != \[9, 10\]\" $REPORT"
  [ "$status" = 0 ]
  # check assert message
  run bash -c "grep -E  \"msg for test_2\" $REPORT"
  [ "$status" = 0 ]
}


@test "check output tests failed (failfast=False, traceback=False, verbosity=0)" {
  PART_ID="ABCG"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  #  check score string
  [ ${lines[1]} = '  "fractionalScore": "0.44",' ]
  # check title
  run bash -c "grep -E \".*feedback.*Test result of the task.*Example task.*Attempt at.*\" $REPORT"
  [ "$status" = 0 ]
  #  check descriptions
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_1. short description for test_1\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_4. short description for test_4\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_5. short description for test_5\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_7. short description for test_7\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[FAILED\] test_summa.TestSumma.test_2. short description for test_2\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[ERROR\] test_summa.TestSumma.test_3. short description for test_3\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[FAILED\] test_summa.TestSumma.test_6 \(i=4\). short description for test_6\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[ERROR\] test_summa.TestSumma.test_6_1 \(i=0\). short description for test_6_1\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[FAILED\] test_summa.TestSumma.test_8. short description for test_8\" $REPORT"
  [ "$status" = 0 ]
  #  check result message
  run bash -c "grep -E  \"Not passed\. Score: 44 points out of 100.\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"To pass the test, you need to score 60 points.\" $REPORT"
  [ "$status" = 0 ]
  # check not traceback
  run bash -c "grep -E  \"Lists differ: \[1, 2, 3, 4, 5\] != \[9, 10\]\" $REPORT"
  [ "$status" = 1 ]
  # check not assert message
  run bash -c "grep -E  \"msg for test_2\" $REPORT"
  [ "$status" = 1 ]
}

