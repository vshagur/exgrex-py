#!/usr/bin/env bats

# set grader name
GRADER="grader_j"

setup() {
  CWD="$PWD"
  REPORT="$PWD/TestGraders/$GRADER/shared/feedback.json"
  COMMAND="$(dirname $PWD)/.env/bin/exgrexCoursera2Py"
  cd "TestGraders/$GRADER"
}

teardown() {
  cd "$CWD"
}

@test "check decorator CheckZipArchive (file is not in archive)" {
  PART_ID="ABCD"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "0",' ]
  # check message
  run bash -c "grep -E \"Grader Error. The solution archive should contain the file: solution.js.\" $REPORT"
  [ "$status" = 0 ]
}
