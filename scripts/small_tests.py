from pathlib import Path

p = "LinAnalgebra/Practice/PracticeNotes.tex"

print(Path(*Path(p).parts[1:]).as_posix())