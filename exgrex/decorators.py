from functools import wraps
from pathlib import Path
import unittest
import shutil
from exgrex.result import LogTestResult
from datetime import datetime


def _getTestSuite(grader):
    loader = unittest.TestLoader()
    suite = loader.discover(Path(grader.cwd, grader.testsDir))

    if not suite.countTestCases():
        grader.abortExecution(
            'Grader error. No tests loaded. Please report to course staff.'
        )

    return suite


class GlueFiles:
    def __init__(self, prefix_file_path=None, postfix_file_path=None, path_to=None,
                 filename=None):
        self.prefixFilePath = prefix_file_path
        self.postfixFilePath = postfix_file_path
        self.pathTo = path_to
        self.filename = filename

    def __call__(self, func):
        @wraps(func)
        def wrapper(grader):

            if self.pathTo is None:
                self.pathTo = grader.testsDir

            if self.filename is None:
                self.filename = grader.solutionFilename

            # set full path and create if not exist
            self.pathTo = Path(grader.cwd, self.pathTo)
            self.pathTo.mkdir(parents=True, exist_ok=True)

            # get prefix file content

            if self.prefixFilePath is None:
                prefixPart = ''
            else:
                self.prefixFilePath = Path(grader.cwd, self.prefixFilePath)
                if not self.prefixFilePath.exists() or not self.prefixFilePath.is_file():
                    grader.abortExecution(
                        f'Grader error. Problems with the prefix file.'
                    )

                try:
                    prefixPart = self.prefixFilePath.read_text()
                except BaseException as err:
                    grader.abortExecution(
                        f'Grader error. Problems getting content from a prefix file.'
                    )

            # get solution content
            try:
                source = next(grader.dirSubmission.iterdir())
                basePart = source.read_text()
            except BaseException as err:
                grader.abortExecution(
                    f'Grader error. Problems getting content from a solution file.'
                )

            # get postfix file content
            if self.postfixFilePath is None:
                postfixPart = ''
            else:
                self.postfixFilePath = Path(grader.cwd, self.postfixFilePath)
                if not self.postfixFilePath.exists() and not self.postfixFilePath.is_file():
                    grader.abortExecution(
                        f'Grader error. Problems with the postfix file.'
                    )

                try:
                    postfixPart = self.postfixFilePath.read_text()
                except BaseException as err:
                    grader.abortExecution(
                        f'Grader error. Problems getting content from a postfix file.'
                    )

            # save content to file
            solutionPath = Path(self.pathTo, self.filename)
            newContent = '\n'.join((prefixPart, basePart, postfixPart))
            solutionPath.write_text(newContent)

            return func(grader)

        return wrapper


class CheckSubmissionFilename:
    def __init__(self, filename):
        self.filename = filename

    def __call__(self, func):
        @wraps(func)
        def wrapper(grader):
            path = next(grader.dirSubmission.iterdir())

            if self.filename != path.name:
                grader.abortExecution(
                    f'Error. Invalid solution file name: {path.name}. The file must '
                    f'be named {self.filename}.'
                )

            return func(grader)

        return wrapper


class CopySolutionFile:
    def __init__(self, pathTo=None, filename=None):
        self.pathTo = pathTo
        self.filename = filename

    def __call__(self, func):
        @wraps(func)
        def wrapper(grader):
            if self.pathTo is None:
                self.pathTo = Path(grader.cwd, grader.testsDir)
            else:
                self.pathTo = Path(grader.cwd, self.pathTo)

            # create if not exist
            self.pathTo.mkdir(parents=True, exist_ok=True)

            if self.filename is not None:
                grader.solutionFilename = self.filename

            try:
                source = next(grader.dirSubmission.iterdir())
                destination = Path(self.pathTo, grader.solutionFilename)
                shutil.copyfile(source.absolute(), destination.absolute())
            except BaseException as err:
                grader.abortExecution(
                    f'Grader error. Error copying solution file.\n{err}'
                )
            return func(grader)

        return wrapper


class RunUnittestTests:
    def __init__(self, test_result_class=None, failfast=True, traceback=True,
                 verbosity=1, pass_rate=1):
        self.failfast = failfast
        self.testResultClass = test_result_class or LogTestResult
        self.verbosity = verbosity
        self.traceback = traceback
        self.passRate = pass_rate
        unittest.TestCase.longMessage = self.traceback

    def __call__(self, func):
        @wraps(func)
        def wrapper(grader):
            unittest.TestCase.longMessage = self.traceback
            suite = _getTestSuite(grader)

            result = self.testResultClass(
                grader.feedbackLogger,
                grader.scoreLogger,
                verbosity=self.verbosity,
                failfast=self.failfast,
                total_tests=suite.countTestCases(),
                pass_rate=self.passRate
            )
            grader.feedbackLogger.error(result.separator)
            grader.feedbackLogger.error(f'Test result of the task: "{grader.task_name}"')
            grader.feedbackLogger.error(f'Attempt at {datetime.now().ctime()}.')

            try:
                grader.testResult = suite.run(result)
            except BaseException as err:
                grader.abortExecution(
                    f'Grader error. The launch of the tests ended with the fall of '
                    f'the grader.\n{err}'
                )

            grader.testResult.wasSuccessful()
            return func(grader)

        return wrapper
