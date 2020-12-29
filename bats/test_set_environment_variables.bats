#!/usr/bin/env bats

# set grader name
GRADER="grader_e"

setup() {
  CWD="$PWD"
  REPORT="$PWD/TestGraders/$GRADER/shared/feedback.json"
  COMMAND="$(dirname $PWD)/.env/bin/exgrexCoursera2Py"
  cd "TestGraders/$GRADER"
}

teardown() {
  cd "$CWD"
}

@test "check set enviroment_variables" {
  PART_ID="ABCD"
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  # check env
  run bash -c "grep \"EXGREX_TESTS_DIR=tests/\" $PART_ID/feedback.log"
  [ "$status" = 0 ]
  run bash -c "grep \"EXGREX_TEST_RUN_COMMAND=python3 execute.py\" $PART_ID/feedback.log"
  [ "$status" = 0 ]
  run bash -c "grep \"EXGREX_FEEDBACK_LOGFILE=feedback.log\" $PART_ID/feedback.log"
  [ "$status" = 0 ]
  run bash -c "grep \"EXGREX_SCORE_LOGFILE=score.log\" $PART_ID/feedback.log"
  [ "$status" = 0 ]
  # todo add check value for EXGREX_DIR_SUBMISSION and EXGREX_PATH_TO_REPORT_FILE
  run bash -c "grep \"EXGREX_DIR_SUBMISSION=\" $PART_ID/feedback.log"
  [ "$status" = 0 ]
  run bash -c "grep \"EXGREX_PATH_TO_REPORT_FILE=\" $PART_ID/feedback.log"
  [ "$status" = 0 ]
}
