from script_common.script_commons import *

from git import Repo

################################################					Settings: 			##############################

decryption = {
	"Analgorithms": "Algorithms and data structures",
	"CUMputerArch": "Computer architecture",
	"DICKreteMath": "Discrete mathematics",
	"LinAnalgebra": "Linear algebra",
	"MathAnalgeBRUH": "Mathematics anal"
}

extensions_for_compilation = {
	".tex" : "compile_latex.py",
	".md" : "compile_md.py"
}




def compile_file(path) -> bool:
	ext = Path(path).suffix
	assert ext in extensions_for_compilation
	
	compiler_script = extensions_for_compilation[ext]
	exit_code = run_python_script(compiler_script)
	if exit_code != 0:
		colored_print(bcolors.FAIL, f"STRONG WARNING: Couldn't compile {ext} file \"{path}\"")
	return exit_code == 0



rep = Repo(this_dir)



# Filter only files for compilation:
files_to_compile = [item.a_path for item in rep.index.diff("HEAD") if Path(item.a_path).suffix in extensions_for_compilation]
print(f"Files to compile: {files_to_compile}")

# COMPILE files:
for source in files_to_compile:
	colored_print(bcolors.OKGREEN, f"Compiling {source}…")
	compile_file(source)


if "--all" in sys.argv[1:]: # Commit all files at once with name provided:
	not_option_ids = [s for s in sys.argv[1:] if s and s[0] != "-"]
	assert len(not_option_ids) == 1
	commit_message = not_option_ids[0]

	# Track all files:
	rep.git.add(all=True)

else:
	pass


	exit()

	# commit_message = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else "Update MathAnalysis conspect"
	commit_message = "Update MathAnalysis conspect"
	if len(sys.argv) > 1:
		commit_message += ": " + " ".join(sys.argv[1:])
	print(f"Commit message will be: \"{commit_message}\"")

	# if not commit_message:
	# 	say, which files are changed:
	# 	commit_message = ""


	print("Compiling…")



exit_data = run_python_script("compile.py")
if exit_data != 0:
	colored_print(bcolors.FAIL, "Failed to comile MathAnalysis conspect! Terminating…")
	exit(1)

colored_print(bcolors.OKGREEN, "Successfully compiled => commiting…")

os.system(f"git add -u ./")
os.system(f"git commit -m \"{commit_message}\"")
