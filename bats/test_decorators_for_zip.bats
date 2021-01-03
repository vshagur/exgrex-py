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

@test "check decorator ExtractFromZip (default parameters)" {
  PART_ID="ABCE"
  # delete solution files
  rm -f $PWD/$PART_ID/tests/solution*
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  [ -f $PWD/$PART_ID/tests/solution.py ]
  [ -f $PWD/$PART_ID/tests/solution1.py ]
  # check content solution file
  run bash -c "cat $PWD/$PART_ID/tests/solution.py"
  [ ${lines[0]} = 'def summa(x, y):' ]
  [ ${lines[1]} = '    return x + y' ]
  run bash -c "cat $PWD/$PART_ID/tests/solution1.py"
  [ ${lines[0]} = 'def summa(x, y):' ]
  [ ${lines[1]} = '    return x + y' ]
}

@test "check decorator ExtractFromZip (extract one file from archive)" {
  PART_ID="ABCF"
  # delete solution files
  rm -f $PWD/$PART_ID/tests/solution*
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  [ ! -f $PWD/$PART_ID/tests/solution.py ]
  [ -f $PWD/$PART_ID/tests/solution1.py ]
  # check content solution file
  run bash -c "cat $PWD/$PART_ID/tests/solution1.py"
  [ ${lines[0]} = 'def summa(x, y):' ]
  [ ${lines[1]} = '    return x + y' ]
}

@test "check decorator ExtractFromZip (extract file to new path_to)" {
  PART_ID="ABCH"
  # clear
  rm -rf $PWD/$PART_ID/new_dir
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  [ -d $PWD/$PART_ID/new_dir ]
  [ ! -f $PWD/$PART_ID/new_dir/solution.py ]
  [ -f $PWD/$PART_ID/new_dir/solution1.py ]
  # check content solution file
  run bash -c "cat $PWD/$PART_ID/new_dir/solution1.py"
  [ ${lines[0]} = 'def summa(x, y):' ]
  [ ${lines[1]} = '    return x + y' ]
}

@test "check decorator ExtractFromZip (extract all to new path_to)" {
  PART_ID="ABCJ"
  # clear
  rm -rf $PWD/$PART_ID/new_dir
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  [ -d $PWD/$PART_ID/new_dir ]
  [ -f $PWD/$PART_ID/new_dir/solution.py ]
  [ -f $PWD/$PART_ID/new_dir/solution1.py ]
  # check content solution files
  run bash -c "cat $PWD/$PART_ID/new_dir/solution.py"
  [ ${lines[0]} = 'def summa(x, y):' ]
  [ ${lines[1]} = '    return x + y' ]
    run bash -c "cat $PWD/$PART_ID/new_dir/solution1.py"
  [ ${lines[0]} = 'def summa(x, y):' ]
  [ ${lines[1]} = '    return x + y' ]
}