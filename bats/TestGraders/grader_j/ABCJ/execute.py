import sys

from exgrex.decorators import ExtractFromZip
from exgrex.graders import UnittestGrader


@ExtractFromZip(path_to='new_dir')
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
