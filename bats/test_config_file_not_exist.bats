#!/usr/bin/env bats

# set grader name
GRADER="grader_a"

setup() {
  CWD="$PWD"
  REPORT="$PWD/TestGraders/$GRADER/shared/feedback.json"
  COMMAND="$(dirname $PWD)/.env/bin/exgrexCourseraPy"
  cd "TestGraders/$GRADER"
}

teardown() {
  cd "$CWD"
}

@test "check output if config file not exist" {
  PART_ID="ABCD"
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$output" = "Grader error. Grader configuration file not found. Please report the course staff." ]
  [ "$status" = 1 ]
}
