import sys

from exgrex.graders import UnittestGrader


def executeGrader(grader):
    """
    :param grader
    :type grader: Grader
    """
    grader.scoreLogger.error(1)
    sys.exit(0)


if __name__ == '__main__':
    grader = UnittestGrader()
    grader.taskName = "Example task."
    executeGrader(grader)
