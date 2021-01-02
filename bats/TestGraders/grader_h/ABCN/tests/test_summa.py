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

    def test_2(self):
        """short description for test_2 """
        # failed test
        self.assertEqual([1, 2, 3, 4, 5], [9, 10], 'assert msg for test_2')

    def test_3(self):
        """short description for test_3"""
        # exceptions
        self.assertEqual(summa(3, 5, 10), 8, 'assert msg for test_3')

    def test_4(self):
        """short description for test_4"""
        # passed test
        self.assertEqual(summa(3, 5), 8, 'assert msg for test_4')

    # def test_5(self):
    #     """short description for test_5"""
    #     # all subtests passed
    #     for i in range(0, 6, 2):
    #         with self.subTest(i=i):
    #             self.assertEqual(i % 2, 0, 'assert msg for test_5')
    #
    # def test_6(self):
    #     """short description for test_6"""
    #     # subtests failed
    #     for i in range(1, 6):
    #         with self.subTest(i=i):
    #             self.assertEqual(i in (1, 2, 3), True, 'assert msg for test_6')
    #
    # def test_6_1(self):
    #     """short description for test_6_1"""
    #     # subtests errors
    #     for i in range(-1, 1):
    #         with self.subTest(i=i):
    #             self.assertEqual(bool(2 / i), True, 'assert msg for test_6_1')
    #
    # def test_7(self):
    #     """short description for test_7"""
    #     with self.assertRaises(ZeroDivisionError, msg='assert msg for test_7'):
    #         2 / 0
    #
    # def test_8(self):
    #     """short description for test_8"""
    #     # passed test
    #     with self.assertRaises(ZeroDivisionError, msg='assert msg for test_8'):
    #         2 / 0
    #
    # def test_9(self):
    #     """short description for test_9"""
    #     # failed test
    #     with self.assertRaises(TypeError, msg='assert msg for test_9'):
    #         2 / 1
