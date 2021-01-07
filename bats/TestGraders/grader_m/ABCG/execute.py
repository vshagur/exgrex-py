import sys

from exgrex.graders import UnittestGrader


def executeGrader(grader):
    """
    :param grader
    :type grader: Grader
    """
    grader.scoreLogger.error(-0.1)
    grader.feedbackLogger.error('feedback')
    sys.exit(0)


if __name__ == '__main__':
    grader = UnittestGrader()
    grader.task_name = "Example task."
    executeGrader(grader)
