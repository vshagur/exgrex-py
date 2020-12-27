#!/usr/bin/env bats

exgrexCoursera2Py=../../.env/bin/exgrexCoursera2Py
cwd=$PWD


@test "check output if config file not exist" {
  run cd TestGraders/grader_a
  run bash -c "env partId=AB $exgrexCoursera2Py"
  [ "$output" = "Grader error. Grader configuration file not found. Please report the course staff." ]
  [ "$status" = 1 ]
}


