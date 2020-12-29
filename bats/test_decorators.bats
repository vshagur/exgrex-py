#!/usr/bin/env bats

# set grader name
GRADER="grader_h"

setup() {
  CWD="$PWD"
  REPORT="$PWD/TestGraders/$GRADER/shared/feedback.json"
  COMMAND="$(dirname $PWD)/.env/bin/exgrexCoursera2Py"
  cd "TestGraders/$GRADER"
}

teardown() {
  cd "$CWD"
}

@test "check decorator CheckSubmissionFilename (invalid solution file name)" {
  PART_ID="ABCD"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  #  check score string
  [ ${lines[1]} = '  "fractionalScore": "0",' ]
  # check title
  run bash -c "grep -E \"Error\. Invalid solution file name: solution\.py\. The file must be named solution_name\.py\.\" $REPORT"
  [ "$status" = 0 ]
}

