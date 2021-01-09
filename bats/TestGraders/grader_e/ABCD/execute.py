import sys
import os

from exgrex.graders import UnittestGrader


def executeGrader(grader):
    """
    :param grader
    :type grader: Grader
    """
    with open('feedback.log', 'a') as file:
        env_names = [
            'EXGREX_DIR_SUBMISSION',
            'EXGREX_PATH_TO_REPORT_FILE',
            'EXGREX_SCORE_LOGFILE',
            'EXGREX_FEEDBACK_LOGFILE',
            'EXGREX_TEST_RUN_COMMAND',
            'EXGREX_TESTS_DIR',
        ]

        for name in env_names:
            file.write(f'{name}={os.environ.get(name)}\n')

    sys.exit(0)


if __name__ == '__main__':
    grader = UnittestGrader()
    grader.taskName = "Example task."
    executeGrader(grader)
