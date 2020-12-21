#!/usr/bin/env bash
# todo добавить описание скрипта

########################################################################
# Cоздает json строку с отчетом и посылает ее в стандартный вывод
# Arguments:
#   score - оценка, количество баллов за решение задания
#   feedback - комментарий к оценке
# Returns:
#   None
########################################################################
function send_report {
  local report
  report=$(jq -n '{"fractionalScore":$fractionalScore, "feedback":$feedback}' \
  --arg fractionalScore "$1" \
  --arg feedback "$2")
  echo "$report"
}


#export PYTHON_HOME=grader
# settings
#todo сделать настройку путей
export DIR_GRADER=/home/ququshka77/Desktop/PROJECTS/Captious/grader/
export DIR_SUBMISSION=/home/ququshka77/Desktop/PROJECTS/Captious/submission
export SCORE_LOGFILE=score.log
export FEEDBACK_LOGFILE=feedback.log
export RUN_TESTS_COMMAND="python3 execute.py"
export DEFAULT_TESTS_DIR=tests/

# Parse the command line arguments supplied by Coursera.
while [[ $# -gt 1 ]]
  do
    key="$1"
    case $key in
      partId)
        # Unique Id associated with the part which is being graded.
        PARTID="$2"
        shift
        ;;
      filename)
        # Original filename as uploaded by the learner.
        # Note: Coursera 'always' renames the This is an optional parameter and
        # most of the graders don't end up using it.
        ORIGINAL_FILENAME="$2"
        shift
        ;;
    esac
  shift
done


# проверка директории с решением
count_files=$(ls -1 $DIR_SUBMISSION | wc -l)

if [[ "$count_files" -eq 0 ]]; then
  send_report 0 "Solution file not found. Please attach the required file."
  exit 0
elif [[ "$count_files" -ne 1 ]]; then
  send_report 0 "Grader error. Multiple solution files found. Please report the course staff."
  exit 0
fi

cd $DIR_GRADER

if [[ ! -d $PARTID ]]; then
  send_report 0 "Grader error. No partId matched. Please report the course staff."
  exit 0
fi

cd $PARTID

# todo сделать вывод потока ошибок в файл
$RUN_TESTS_COMMAND > /dev/null 2>&1

if [[ $? -eq 0 ]]; then
  # todo сделать проверку существования файлов
  fractionalScore=$(<$SCORE_LOGFILE)
  feedback=$(<$FEEDBACK_LOGFILE)
  send_report "$fractionalScore" "$feedback"
else
  # todo добавить в вывод сообщение об ошибке
  send_report 0 "Grader error. Runtime error occured. Please report the course staff."
fi

exit 0
