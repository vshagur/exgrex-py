import sys

from exgrex.decorators import (CheckSubmissionFilename,
                               CopySolutionFile,
                               RunUnittestTests)
from exgrex.graders import UnittestGrader
from exgrex.result import LogTestResult


@CopySolutionFile()
@RunUnittestTests(
    test_result_class=LogTestResult, failfast=True, traceback=False, verbosity=0,
    pass_rate=0.1
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
