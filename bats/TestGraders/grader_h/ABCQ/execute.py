import sys

from exgrex.decorators import (CheckZipArchive)
from exgrex.graders import UnittestGrader


@CheckZipArchive()
def executeGrader(grader):
    """
    :param grader
    :type grader: Grader
    """
    sys.exit(0)


if __name__ == '__main__':
    grader = UnittestGrader()
    grader.taskName = "Example task."
    executeGrader(grader)
