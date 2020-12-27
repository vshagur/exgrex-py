#!/usr/bin/env bats

# set grader name
GRADER="grader_c"
PART_ID="ABCD"

setup() {
  CWD="$PWD"
  REPORT="$PWD/TestGraders/$GRADER/shared/feedback.json"
  COMMAND="$(dirname $PWD)/.env/bin/exgrexCoursera2Py"
  cd "TestGraders/$GRADER"
}

teardown() {
  cd "$CWD"
}

@test "check output all test passed" {
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "grep 'Congratulations! All tests passed!' $REPORT"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  [ ${lines[1]} = '  "fractionalScore": "1.0",' ]
}


#@test "check output all test 1" {
#  run bash -c "env partId=ABCD $exgrexCoursera2Py"
#  [ "$status" = 0 ]
#  run bash -c "grep 'Congratulations! All tests passed!' $result_path"
#  [ "$status" = 0 ]
#  run bash -c "cat $result_path"
#  [ ${lines[1]} = '  "fractionalScore": "1.0",' ]
#}
