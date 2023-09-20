from git import Repo
from scripts.script_commons import *

rep = Repo(conspects_root_dir)

rep.git.add(all=True)
compiled_pdfs = [item.b_path for item in rep.head.commit.diff(None) if Path(item.b_path).suffix == ".pdf"]
if compiled_pdfs:
    compiled_names = [Path(path).stem for path in compiled_pdfs]
    message = f"Compile these conspects: {', '.join(compiled_names)}"
    print(message, end='')
    
print(end='')
