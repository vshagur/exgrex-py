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
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "0",' ]
  # check title
  run bash -c "grep -E \"Error. Invalid solution file name: solution.py. The file must be named solution_name.py.\" $REPORT"
  [ "$status" = 0 ]
}

@test "check decorator CopySolutionFile (default)" {
  PART_ID="ABCE"
  # delete the contents of the report file
  echo "" > $REPORT
  # delete destination file
  rm -f $PWD/$PART_ID/tests/solution.py
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "1.0",' ]
  # check file created
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

@test "check decorator CopySolutionFile (Error copying solution file)" {
  PART_ID="ABCH"
  # disable writing to the directory
  chmod 555 $PWD/$PART_ID/some_dir
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  # check score string
  run bash -c "cat $REPORT"
  [ ${lines[1]} = '  "fractionalScore": "0",' ]
  # check file not created
  [ ! -f $PWD/$PART_ID/some_dir/some_file.py ]
  # check title
  run bash -c "grep -E \"Grader error. Error copying solution file.\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \"\[Errno 13\] Permission denied: \" $REPORT"
  [ "$status" = 0 ]
}

@test "check decorator RunUnittestTests (No tests loaded)" {
  PART_ID="ABCJ"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "0",' ]
  # check title
  run bash -c "grep -E \"Grader error. No tests loaded. Please report to course staff.\" $REPORT"
  [ "$status" = 0 ]
}

@test "check decorator RunUnittestTests (passed test: 0.5, pass_rate: 0.5)" {
  PART_ID="ABCK"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "1.0",' ]
  # check title
  run bash -c "grep -E \"Passed. Score: 50 points out of 100.\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \"You have scored the required number of points to pass the test.\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \"If you want, you can try to take the test again and get a higher grade.\" $REPORT"
  [ "$status" = 0 ]
}

@test "check decorator RunUnittestTests (passed test: 0.44, pass_rate: 0.45)" {
  PART_ID="ABCL"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "0.44",' ]
  # check title
  run bash -c "grep -E \"Not passed. Score: 44 points out of 100.\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \"To pass the test, you need to score 45 points.\" $REPORT"
  [ "$status" = 0 ]
}

@test "check decorator RunUnittestTests (failfast=True)" {
  PART_ID="ABCM"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "0",' ]
  # check title
  run bash -c "grep -E \"Not passed. Try again\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \"\[FAILED\] test_summa.TestSumma.test_9. short description for test_9\" $REPORT"
  [ "$status" = 0 ]
}


@test "check decorator GlueFiles (prefile not exist)" {
  PART_ID="ABCN"
  # delete the contents of the report file
  echo "" > $REPORT
  # clear solution file
  echo '' > $PWD/$PART_ID/tests/solution.py
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  run bash -c "grep -E \"Grader error. Invalid file path passed for before.txt.\" $REPORT"
  [ "$status" = 0 ]
}

@test "check decorator GlueFiles (postfile not exist)" {
  PART_ID="ABCP"
  # delete the contents of the report file
  echo "" > $REPORT
  # clear solution file
  echo '' > $PWD/$PART_ID/tests/solution.py
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  run bash -c "grep -E \"Grader error. Invalid file path passed for after.txt.\" $REPORT"
  [ "$status" = 0 ]
}

@test "check decorator GlueFiles (the content of the solution file is correct)" {
  PART_ID="ABCS"
  # delete the contents of the report file
  echo "" > $REPORT
  # clear solution file
  echo '' > $PWD/$PART_ID/tests/solution.py
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "1.0",' ]
  # check content solution file
  run bash -c "cat $PWD/$PART_ID/tests/solution.py"
  [ ${lines[0]} = '# before.txt' ]
  [ ${lines[1]} = 'def summa(x, y):' ]
  [ ${lines[2]} = '    return x + y' ]
  [ ${lines[3]} = '# after.txt' ]
}

@test "check decorator GlueFiles (the path to solution file is not default)" {
  PART_ID="ABCT"
  # delete the contents of the report file
  echo "" > $REPORT
  # delete new solution dir
  rm -f $PWD/$PART_ID/new_dir/new_solution.py
  if [ -d $PWD/$PART_ID/new_dir ]; then
    rmdir $PWD/$PART_ID/new_dir/
  fi
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # the solution file is exist
  [ -f $PWD/$PART_ID/new_dir/new_solution.py ]
  # check content solution file
  run bash -c "cat $PWD/$PART_ID/new_dir/new_solution.py"
  [ ${lines[0]} = '# before.txt' ]
  [ ${lines[1]} = 'def summa(x, y):' ]
  [ ${lines[2]} = '    return x + y' ]
  [ ${lines[3]} = '# after.txt' ]
}

@test "check decorator CheckZipArchive (solution file is not zip archive)" {
  PART_ID="ABCQ"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": "0",' ]
  # check message
  run bash -c "grep -E \"Grader Error. Submission should be zip archive.\" $REPORT"
  [ "$status" = 0 ]
}
