from script_common.script_commons import *

exit_data = run_python_script("commit.py")
if exit_data != 0:
	colored_print(bcolors.FAIL, "Failed to compile or commit => can't push! Terminating…")
	exit(1)

colored_print(bcolors.OKGREEN, "Successfully compiled && commited => pushing")

os.system("git push origin master")