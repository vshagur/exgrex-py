import sys

from exgrex.decorators import (CheckSubmissionFilename,
                               CopySolutionFile,
                               RunUnittestTests)
from exgrex.graders import UnittestGrader
from exgrex.result import LogTestResult


@CheckSubmissionFilename('solution_name.py')
@CopySolutionFile()
@RunUnittestTests(
    test_result_class=LogTestResult, failfast=False, traceback=True, verbosity=2,
    pass_rate=0.6
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
