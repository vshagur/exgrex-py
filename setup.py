#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from distutils.core import setup
from setuptools import find_packages

with open("README", "r") as fh:
    long_description = fh.read()

setup(name='exgrex',
      version='0.1.1',
      description='Exgrex implementation for the Python programming language.',
      long_description=long_description,
      long_description_content_type="text/markdown",
      author='vshagur',
      author_email='vshagur@gmail.com',
      packages=find_packages(
          exclude=['tests', '*.test.*', '*.test', 'bats', '*.bats.*', '*.bats', ]
      ),
      scripts=["bin/exgrexCourseraPy", "bin/exgrexCoursera2Py", ],
      keywords=['mooc', 'grader', 'python', 'python3', 'education', 'exgrex'],
      url='https://github.com/vshagur/exgrex-py',
      classifiers=[
          "Programming Language :: Python :: 3",
          "License :: OSI Approved :: MIT License",
          "Operating System :: POSIX :: Linux", ],
      )
