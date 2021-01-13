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

@test "check output for partId env not set" {
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "$COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": 0,' ]
  # check feedback string
  [ ${lines[2]} = '  "feedback": "Grader error. Environment variable partId is not set. Please report the course staff."' ]
}

@test "check output for not valid partId" {
  PART_ID="NOTVALID"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": 0,' ]
  # check feedback string
  [ ${lines[2]} = '  "feedback": "Grader error. No partId matched. Please report the course staff."' ]
}
