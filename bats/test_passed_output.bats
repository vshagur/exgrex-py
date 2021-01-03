#!/usr/bin/env bats

# set grader name
GRADER="grader_c"

setup() {
  CWD="$PWD"
  REPORT="$PWD/TestGraders/$GRADER/shared/feedback.json"
  COMMAND="$(dirname $PWD)/.env/bin/exgrexCoursera2Py"
  cd "TestGraders/$GRADER"
}

teardown() {
  cd "$CWD"
}


@test "check output all test passed (failfast=False, traceback=True, verbosity=2)" {
  # check output for testcase - all tests passed for verbosity=2
  PART_ID="ABCD"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "1.0",' ]
  # check title
  run bash -c "grep -E \".*feedback.*Test result of the task.*Example task.*Attempt at.*\" $REPORT"
  [ "$status" = 0 ]
  # check descriptions
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_1. short description for test_1\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_4. short description for test_4\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_5. short description for test_5\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_8. short description for test_8\" $REPORT"
  [ "$status" = 0 ]
  # check result message
  run bash -c "grep 'Congratulations! All tests passed!' $REPORT"
  [ "$status" = 0 ]
}


@test "check output all test passed (failfast=False, traceback=True, verbosity=1)" {
  # check output for testcase - all tests passed for verbosity=1
  PART_ID="ABCE"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "1.0",' ]
  # check title
  run bash -c "grep -E \".*feedback.*Test result of the task.*Example task.*Attempt at.*\" $REPORT"
  [ "$status" = 0 ]
  # check descriptions not exist
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_1. short description for test_1\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_4. short description for test_4\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_5. short description for test_5\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_8. short description for test_8\" $REPORT"
  [ "$status" = 1 ]
  # check result message
  run bash -c "grep 'Congratulations! All tests passed!' $REPORT"
  [ "$status" = 0 ]
}

@test "check output all test passed (failfast=False, traceback=True, verbosity=0)" {
  # check output for testcase - all tests passed for verbosity=0
  PART_ID="ABCF"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "1.0",' ]
  # check title
  run bash -c "grep -E \".*feedback.*Test result of the task.*Example task.*Attempt at.*\" $REPORT"
  [ "$status" = 0 ]
  # check descriptions not exist
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_1. short description for test_1\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_4. short description for test_4\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_5. short description for test_5\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_8. short description for test_8\" $REPORT"
  [ "$status" = 1 ]
  # check result message
  run bash -c "grep 'Congratulations! All tests passed!' $REPORT"
  [ "$status" = 0 ]
}

@test "check output all test passed (with CheckFileAsModule decorators)" {
  # check output for testcase - all tests passed for verbosity=2
  PART_ID="ABCG"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "1.0",' ]
  # check title
  run bash -c "grep -E \".*feedback.*Test result of the task.*Example task.*Attempt at.*\" $REPORT"
  [ "$status" = 0 ]
  # check descriptions
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_1. short description for test_1\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_4. short description for test_4\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_5. short description for test_5\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E  \"\[PASSED\] test_summa.TestSumma.test_8. short description for test_8\" $REPORT"
  [ "$status" = 0 ]
  # check result message
  run bash -c "grep 'Congratulations! All tests passed!' $REPORT"
  [ "$status" = 0 ]
}

