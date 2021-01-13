#!/usr/bin/env bats

# set grader name
GRADER="grader_d"

setup() {
  CWD="$PWD"
  REPORT="$PWD/TestGraders/$GRADER/shared/feedback.json"
  COMMAND="$(dirname $PWD)/.env/bin/exgrexCourseraPy"
  cd "TestGraders/$GRADER"
}

teardown() {
  cd "$CWD"
}

@test "check output for solution file not found" {
  PART_ID="ABCD"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": 0,' ]
  # check feedback string
  [ ${lines[2]} = '  "feedback": "Solution file not found. Please attach the required file."' ]
}
