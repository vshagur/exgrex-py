import sys

from exgrex.decorators import (GlueFiles,
                               RunUnittestTests)
from exgrex.graders import UnittestGrader
from exgrex.result import LogTestResult


@GlueFiles(prefix_file_path='before.txt', postfix_file_path='after.txt')
@RunUnittestTests(
    test_result_class=LogTestResult, failfast=False, traceback=False, verbosity=0,
    pass_rate=0.5
)
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
