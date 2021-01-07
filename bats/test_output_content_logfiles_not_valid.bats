#!/usr/bin/env bats

# set grader name
GRADER="grader_m"

setup() {
  CWD="$PWD"
  REPORT="$PWD/TestGraders/$GRADER/shared/feedback.json"
  COMMAND="$(dirname $PWD)/.env/bin/exgrexCoursera2Py"
  cd "TestGraders/$GRADER"
}

teardown() {
  cd "$CWD"
}

@test "check output (score logfile is empty)" {
  PART_ID="ABCD"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "0",' ]
  # check feedback string
  run bash -c "grep -E \"Grader error. The log file with scores is empty. Please report the course staff.\" $REPORT"
  [ "$status" = 0 ]
}

@test "check output (feedback logfile is empty)" {
  PART_ID="ABCE"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "0",' ]
  # check feedback string
  run bash -c "grep -E \"Grader error. The log file with feedback is empty. Please report the course staff.\" $REPORT"
  [ "$status" = 0 ]
}

@test "check output (score > 1)" {
  PART_ID="ABCF"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "0",' ]
  # check feedback string
  run bash -c "grep -E \"Grader error. Invalid score received. Please report the course staff.\" $REPORT"
  [ "$status" = 0 ]
}

@test "check output (score < 0)" {
  PART_ID="ABCG"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "0",' ]
  # check feedback string
  run bash -c "grep -E \"Grader error. Invalid score received. Please report the course staff.\" $REPORT"
  [ "$status" = 0 ]
}