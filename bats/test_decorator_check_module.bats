#!/usr/bin/env bats

# set grader name
GRADER="grader_k"

setup() {
  CWD="$PWD"
  REPORT="$PWD/TestGraders/$GRADER/shared/feedback.json"
  COMMAND="$(dirname $PWD)/.env/bin/exgrexCourseraPy"
  cd "TestGraders/$GRADER"
}

teardown() {
  cd "$CWD"
}

@test "check decorator CheckFileAsModule (import error)" {
  PART_ID="ABCD"
  # clear
  rm -rf $PWD/$PART_ID/tests/solution.py
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "0",' ]
  # check message
  run bash -c "grep -E \"Grader Error. An attempt to import the solution file as a module failed. Error: invalid syntax \(solution.py, line 1\).\" $REPORT"
  [ "$status" = 0 ]
}