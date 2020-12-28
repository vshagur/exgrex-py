from exgrex.graders import UnittestGrader, createFileLogger
from exgrex.decorators import CheckSubmissionFilename, CopySolutionFile, \
    RunUnittestTests, GlueFiles
import sys
from exgrex.result import LogTestResult


@CheckSubmissionFilename('solution.py')
@CopySolutionFile()
# @GlueFiles(prefix_file_path='precode', postfix_file_path='postcode', path_to=None,
#                  filename=None)
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


# декораторы:
# 3. проверить возможность импорта решения, как модуля
# 4. запуск тестов
# 5. получение результата тестов и запись их в лог файлы
# ====================================================================================
# отладочный код
# ====================================================================================
if __name__ == '__main__':
    grader = UnittestGrader()
    grader.task_name = "Example task."
    executeGrader(grader)
