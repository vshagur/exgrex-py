#!/usr/bin/env bats


setup() {
  cwd=$PWD
  result_path="$PWD/TestGraders/shared/feedback.json"
  cd ../../
  exgrexCoursera2Py="$PWD/.env/bin/exgrexCoursera2Py"
  cd $cwd
  cd TestGraders/grader_c
}

teardown() {
  cd $cwd
}

@test "check output all test passed" {
  run bash -c "env partId=ABCD $exgrexCoursera2Py"
  [ "$status" = 0 ]
  run bash -c "grep 'Congratulations! All tests passed!' $result_path"
  [ "$status" = 0 ]
  run bash -c "cat $result_path"
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
