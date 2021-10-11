import os
import sys
import time

from pathlib import Path
from inspect import getsourcefile
from os.path import abspath


from typing import Callable, Iterable, List

import itertools as it
import random


conspects_root_dir = Path(abspath(getsourcefile(lambda: 0))).parent.parent.absolute()


class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


def run_command(command):
    exit_data = os.system(command)
    return exit_data >> 8 if os.name == 'posix' else exit_data


def run_python_script(path_to_script, *args):
    arg_string = "".join(list(args))
    return run_command(f"{'python3' if os.name == 'posix' else 'python'} {path_to_script} {arg_string}")


def colored_print(color, string, *args, **kwargs):
    print(color, string, bcolors.ENDC, *args, **kwargs)

def print_red(string, *args, **kwargs):
    colored_print(bcolors.FAIL, string, *args, **kwargs)

def print_green(string, *args, **kwargs):
    colored_print(bcolors.OKGREEN, string, *args, **kwargs)



def split(sequence: Iterable, pred: Callable):
    """ Splits sequence into two parts by predicate: trues, falses """
    sat, non_sat = [], []
    for el in sequence:
        if pred(el):
            sat.append(el)
        else:
            non_sat.append(el)

    return sat, non_sat

def try_return(to_try, default):
    if to_try:
        return to_try
    else:
        return default


if __name__ == '__main__':
    colored_print(bcolors.FAIL, float("NaN") ** float("NaN"))
