import os
import sys
import logging
from pathlib import Path


def createFileLogger(logger_name, filename, template):
    logger = logging.getLogger(logger_name)
    handler = logging.FileHandler(filename)
    handler.setFormatter(logging.Formatter(template))
    logger.addHandler(handler)
    return logger


class UnittestGrader:

    def __init__(self):
        self.task_name = None
        self.testResult = None
        self.totalTests = 0
        self.solutionFilename = 'solution.py'
        self.cwd = Path.cwd()
        self.dirSubmission = Path(os.environ.get('DIR_SUBMISSION'))
        self.testsDir = Path(os.environ.get('DEFAULT_TESTS_DIR'))
        # логи
        self.scoreLogFile = Path(self.cwd, os.environ.get('SCORE_LOGFILE'))
        self.feedbackLogFile = Path(self.cwd, os.environ.get('FEEDBACK_LOGFILE'))
        # очистка логов
        for logFile in (self.scoreLogFile, self.feedbackLogFile):
            logFile.write_text('')
        # логгеры
        self.scoreLogger = createFileLogger(
            'scoreLogger', self.scoreLogFile, '%(message)s'
        )
        self.feedbackLogger = createFileLogger(
            'feedbackLogger', self.feedbackLogFile, '%(message)s'
        )

    def __repr__(self):
        return str(self.__dict__)

    def abortExecution(self, message):
        self.scoreLogger.error(0)
        self.feedbackLogger.error(message)
        sys.exit(0)
