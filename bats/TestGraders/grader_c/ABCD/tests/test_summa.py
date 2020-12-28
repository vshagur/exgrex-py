import unittest
from solution import summa


class TestSumma(unittest.TestCase):

    def test_1(self):
        """short description for test_1
        new line for short description
        """
        # passed test
        self.assertEqual(summa(3, 5), 8, 'assert msg for test_1')

    def test_4(self):
        """short description for test_4"""
        # passed test
        self.assertEqual(summa(3, 5), 8, 'assert msg for test_4')

    def test_5(self):
        """short description for test_5"""
        # all subtests passed
        for i in range(0, 6, 2):
            with self.subTest(i=i):
                self.assertEqual(i % 2, 0, 'assert msg for test_5')

    def test_8(self):
        """short description for test_8"""
        # passed test
        with self.assertRaises(ZeroDivisionError, msg='assert msg for test_8'):
            2 / 0
