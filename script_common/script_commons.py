import os
import sys
import time

from pathlib import Path
from inspect import getsourcefile
from os.path import abspath

from typing import Callable


this_dir = Path(abspath(getsourcefile(lambda: 0))).parent.parent.absolute()


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


def run_python_script(path_to_script):
    return run_command(f"{'python3' if os.name == 'posix' else 'python'} {path_to_script}")    


def colored_print(color, string, **kwargs):
    print(color + string + bcolors.ENDC, **kwargs)



if __name__ == '__main__':
    colored_print(bcolors.FAIL, "Fail")
