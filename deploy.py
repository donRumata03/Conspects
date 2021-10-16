from scripts.script_commons import *

exit_data = run_python_script("commit.py")
if exit_data != 0:
	colored_print(console_colors.FAIL, "Failed to commit => can't push! Terminating…")
	exit(1)

print_green("[Deployer] Successfully compiled && committed => pushing")

os.system("git push origin master")

