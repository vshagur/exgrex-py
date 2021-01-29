#!/usr/bin/env bats

# set grader name
GRADER="grader_c"

setup() {
  CWD="$PWD"
  REPORT="$PWD/TestGraders/$GRADER/shared/feedback.json"
  COMMAND="$(dirname $PWD)/.env/bin/exgrexCourseraPy"
  cd "TestGraders/$GRADER"
}

teardown() {
  cd "$CWD"
}

@test "check output for run tests autograder 1 (passed)" {
  PART_ID="ABCD"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "$COMMAND partId $PART_ID"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  #  check score string
  [ ${lines[1]} = '  "fractionalScore": 1,' ]
  # check title
  run bash -c "grep -E \".*feedback.*Test result of the task.*Example task.*Attempt at.*\" $REPORT"
  [ "$status" = 0 ]
  #  check result message
  run bash -c "grep -E  \"Congratulations! All tests passed!\" $REPORT"
  [ "$status" = 0 ]
}
