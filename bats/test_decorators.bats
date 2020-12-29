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

@test "check decorator CopySolutionFile (default)" {
  PART_ID="ABCE"
  # delete the contents of the report file
  echo "" > $REPORT
  # delete destination file
  rm $PWD/$PART_ID/tests/solution.py
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  #  check score string
  [ ${lines[1]} = '  "fractionalScore": "1.0",' ]
#  check file created
  [ -f $PWD/$PART_ID/tests/solution.py ]
  # check content
  run cmp -s $PWD/$PART_ID/tests/solution.py $PWD/shared/submission/solution.py
  [ "$status" = 0 ]
}

@test "check decorator CopySolutionFile (pathTo='some_dir', filename='some_file.py')" {
  PART_ID="ABCF"
  # delete destination file
  rm -rf $PWD/$PART_ID/some_dir
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  # check file created
  [ -f $PWD/$PART_ID/some_dir/some_file.py ]
  # check content
  run cmp -s $PWD/$PART_ID/some_dir/some_file.py $PWD/shared/submission/solution.py
  [ "$status" = 0 ]
}