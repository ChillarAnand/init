# flake8: NOQA
# encoding: UTF-8

import os
import sys


# import_standard_library
def import_std_lib():
    try:
        from stdlib_list import stdlib_list

        version = sys.version[:3]
        libs = stdlib_list(version)

        for lib in libs:
            statement = 'import {}'.format(lib)

            try:
                exec(statement)
            except ImportError:
                pass
    except:
        print('Couldnt import entire stdlib')



# stdlib extra imports
# from collections import *

from datetime import *
from datetime import datetime as dt
now = dt.now()

from functools import *

from distutils.version import *
lv = LooseVersion

# from packaging.version import *
# v = Version

from pprint import pprint
pp = pprint

from unicodedata import *



# 3rd party libraries
try:
    # import celery
    # from celery import current_app, chain, chord, group
    # from celery.task.control import revoke, inspect, discard_all

    import numpy as np

    import pandas as pd
    from pandas import DataFrame

    # from PIL import Image, ImageFont, ImageDraw, ImageChops

    # from pyflash.core import *

    # import redis
    # rc = redis.StrictRedis(host='localhost', port=6379, db=0)

    # from nsepy import get_history

    # from t import *

    # import importmagic
    # index = importmagic.SymbolIndex()
    # index.get_or_create_index(name='py35', paths=['.'] + sys.path)

except Exception as e:
    print(e)

# try:
#     exec(open('./scripts/django_shell_plus_init.py').read())
# except:
#     pass


def f(*args, **kwargs):
    print('sample function with {}, {}'.format(args, kwargs))

foo = f


def add(x, y):
    print('calculatin {} + {}'.format(x, y))
    return x + y


# data
l = [None, 3, 5.0, 'aaew', 23]
d = {1: 2, "a": "b", }
t = (1, "aaa", 4.5, None, )
s = {1, "333", "foo"}


# data analysis
columns =  ['name', 'float', 'gender', 'bool', 'complex', 'int', 'sint', 'date', 'sdate']
data = [
    ['anand', 2, 'M', True, '1j', 2, '-1', '20200101', '2001-01-01'],
    ['test', -2, 'N/A', True, '3j', 4, '-2', None, ''],
    ['nanda', 3, 'M', False, '2j', 3, '2', '', ''],
    ['multi', 2.0, 'F', True, '-2j', 1, '3', pd.NaT, ''],
    ['test', -2, 'N/A', True, '3j', 4, '-2', '', ''],
    ['float', 2.34, 'N/A', False, '2j', 3, '1', '20500102', ''],
]

df = pd.DataFrame(data, columns=columns)

data = [
    ['anand', 2, 'M', True, '1j', 2, '-1', '20200101', '2001-01-01'],
    ['test', -2, 'N/A', True, '3j', 4, '-2', None, ''],
    ['nanda', 3, 'M', False, '2j', 3, '2', '', ''],
    ['multi', 2.0, 'F', True, '-2j', 1, '3', pd.NaT, ''],
    ['float', 2.34, 'N/A', False, '2j', 3, '1', '20500102', ''],
    ['test', -2, 'N/A', True, '3j', 4, '-2', '', ''],

]
df2 = pd.DataFrame(data, columns=columns)


# os.system('cls' if os.name == 'nt' else 'clear')

message = r"""
 ________________________________________
< Supercharged iPython shell launched... >
 ----------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
"""
print(message)
