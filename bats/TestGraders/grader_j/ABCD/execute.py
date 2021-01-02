import sys

from exgrex.decorators import (CheckZipArchive)
from exgrex.graders import UnittestGrader


@CheckZipArchive(filenames=['solution.py', 'solution1.py', 'solution.js', ])
def executeGrader(grader):
    """
    :param grader
    :type grader: Grader
    """
    sys.exit(0)


if __name__ == '__main__':
    grader = UnittestGrader()
    grader.task_name = "Example task."
    executeGrader(grader)
