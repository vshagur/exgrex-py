import sys

from exgrex.decorators import (GlueFiles, )
from exgrex.graders import UnittestGrader


@GlueFiles(prefix_file_path='before.txt', postfix_file_path='after.txt',
           path_to='new_dir', filename='new_solution.py')
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
