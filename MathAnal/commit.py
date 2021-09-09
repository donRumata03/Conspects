import sys
import os


# commit_message = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else "Update MathAnalysis conspect"
commit_message = "Update MathAnalysis conspect"
if len(sys.argv) > 1:
	commit_message += ": " + " ".join(sys.argv[1:])
print(f"Commit message will be: \"{commit_message}\"")

# if not commit_message:
# 	say, which files are changed:
# 	commit_message = ""


print("Compiling…")
exit_data = os.system("compile.py")
if exit_data != 0:
	print("Failed to comile MathAnalysis conspect! Terminating…")

print("Successfully compiled => commiting…")

os.system(f"git add -u ./")
os.system(f"git commit -m \"{commit_message}\"")
