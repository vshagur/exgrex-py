import unittest
from tests.solution import summa


class TestSumma(unittest.TestCase):

    # longMessage = False # отключить трейсбек

    def test_1(self):
        """short description for test_1
        new line for short description
        """
        # passed test
        self.assertEqual(summa(3, 5), 8, 'assert msg for test_1')
