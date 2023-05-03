# Conspects && useful resources

ITMO CT (Applied Mathematics and Computer Science) group M3*38 (y2021) useful resources in Russian including:

- _**Conspects of practices**_
- _**Aggressively compressed conspects for exams and future knowledge recollection**_
- Conspects of a little part of lections (for the guys who don't have time to read long conspects let alone watching lections)
- Some of the HomeTasks (e. g. Linear algebra «типовики», Math Logic, )

## Featured subjects

- [Mathematical analysis](MathAnal)
- [Linear algebra](LinAnalgebra)
- [Probability theory](BillyTheory)
- [Math Logic](MathCOQ)

## Abandoned subjects
- [Algorithms and data structures](Analgorithms) still some home tasks are present
- [Discrete Mathematics](DICKreteMath)
- [Computer architecture](CUMputerAAAAAAAAH)
- [History (reforms and reformers in Russian history), also known as FISTory](Fistory) — the course is over, but the conspect is still _in progress_…
  In an infinite progress, to be precise… 

## Links

Apart from this, you would probably want to use these resources (the ones dedicated to course organization are not listed)
- Sources of Timofey Ivanov's exhaustive lecture conspects at Overleaf: 
  - SemenAssters 1-2: https://www.overleaf.com/read/hcmjjqmhwqzx
  - -||- 3-4: https://www.overleaf.com/read/zvkmsvcphwym
- Textbooks, Task books (+ answers for some of them), some home tasks, Timofey's conspects regulary being compiled and updated by @donRumata at yandex disk: https://disk.yandex.ru/d/BeIxqrNHSvqx0w
- Resources connected to differential equations course (by German Andosov): https://docs.google.com/document/d/e/2PACX-1vQv0RikC6gGVkdBqHChc_A06rhWAlUYwyhBQLSy51lozPgjk5Fz6h8ofjJ06ybdAmBt_6p1nRiFOuLd/pub
- Public CT YouTube channel with lection streams and recordings scrupulously sorted by playlists: https://www.youtube.com/channel/UCc8_XiJXPMz699NvDmtGoTA

## Awaited subjects which already have names for their folders:
- FuckToAnal Programming (functional)
- ~~Programming PornoDicks (Paradigms)~~ (actually, this course is already over…)

## Conception

This repository is intended for wide collaboration of students for conspect production (fortunately, GitHub is ideal for such regime).

If you want to contribute, you can either install all the tools for fully-fledged development or just add some latex- or md- shaped text with plane text editor.

After that you are welcome to open pull request and if the strict compiler doesn't like something, I'll fix that. 

## Brief technical description 

There are three major conspect formats:
- [Typst](https://github.com/typst/typst) — The new LaTeX && Markdown killer written in Rust.
  It incorporates the best qualities of both: the MD's simplicity of typical case
  and LaTeX's customizability of a hard one.
- LaTeX
- Markdown

all of them are compiled to pdf and the artifacts are stored in this repo.

### Typst compilation

It's easy here: [install](https://github.com/typst/typst) it with package manager and compile with `typst compile {file}`
or `typst watch {file}` (for continuous compilation).

It goes without saying that compilation is _blazingly fast_ (due to incremental compilation and _wise language choice_).
It really changes the way you work with typesetting systems: the on-the-fly preview now justifies this name…

### Markdown compilation

Markdown compilation is done by pandoc which is translated to LaTeX and then compiled by XeLaTeX.


### LaTeX compilation

Latex is compiled through the XeLaTeX compiler
(its killer features were modern font support (unlike pdfLaTeX) and relatively fast compilation times compared to LuaLaTeX).
And .md files are compiled to pdf by [pandoc](https://pandoc.org/).

But, unfortunately, these tools require: too much command line arguments and escaping characters, clearing temp files, providing temp files and many other additional procedures.
[latexmk](https://mg.readthedocs.io/latexmk.html) partially solves the issues, but still leaves much to be desired.

To automate those actions there are some scripts written within the framework of this repo.
Moreover, the scripts are also capable of detecting you changes (using Git API), 
committing them with proper commit messages and splitting the changes between commits wisely.


## Requierd tools' installation

- For Typst: follow this [link](https://github.com/typst/typst) and the instructions there.
- For latex, firstly ensure that you have a working latex distribution. The mainstream options are: tex-live for Linux && MacOS and MikTex for Windows.
  Note that MikTex automatically installs all required packages at compilation while tex-live requiers them to be pre-downloaded by `tlmgr` (tex-live manager) utility.
  If you experience problems with `tlmgr`'s work, visit [this page](https://tex.stackexchange.com/questions/540429/tlmgr-in-ubuntu-20-04-local-tex-live-2019-is-older-than-remote-repository-2).
  As you can see, compiling everything successfully with tex-live (especially for the first time) would inevitably lead to big buttheart…
- Install font pack from directory `Fonts/Kurale`
- Install latexmk (via package manager on Linux or from binaries. In the second case — don't forget to install perl before…)
- Install an IDE for efficient work with latex
  (For latex I've recently switched to Visual Studio Code from Texify Idea. It's a bit less clever but offers some tasty features…)
  For Typst I recommend to use VS Code with Typst extension.
- To compile Markdown to pdf from console you also need to install pandoc. There are should not be any pitfalls: just do it!
- For editing Markdown files I recommend [Obsidian markdown editor](https://obsidian.md/).
  As well as pandoc, Obsidian supports something called «enriched markdown» (my own term).
  But it's much more convenient to edit md conspects in Obsidian but compile through pandoc automatically in commit script. 
  Unfortunately, «enriched markdowns» are a bit different and not fully compatible, 
  so you probably need to make sure that you files are maintained compilable…


## Building with scripts

Now, when all the desired software is installed, it's time to get used to python scripts for common operations with conspects.

This is what scripts are responsible for:
- Compiling Typst source code to PDFs
- Compiling LaTeX source code to PDFs with special settings (latexmk; xelatex)
- Compiling Markdown source code to PDFs with special settings
- Tracking changes using git api
- Distributing changes between commits smartly
- Committing naming based on folders in which the changes were made
- Fully automatically performing the actions above and running ``git push`` after that.

Those things can drastically boost your performance at writing electronic conspects.

Basically, typical workflow is as following (consists of 2 (two) steps):
- Write some code in a typst/latex editor. Optionally - use its recompiling-on-fly features to see what you are typing.
- Just run python script ``./deploy.py``. It will do all these things do you:
  - Compile changed conspect source files
  - Perform a clean-up by removing cache files generated while compilation
  - For each committing group - ``git add`` it; 
    ``commit`` with respective message;
  - ``git push`` the commits to ``origin/master`` branch

> Stop those stupid attempts of renaming ``master`` branch to ``main``!
> The master will finally punish such naughty slaves!

At the moment there are the following script files intended for simplifying 
everyday conspectors' activities:

- deploy.py - description's already provided above
- commit.py - is responsible for all `deploy`'s work except running `git push`
- compile_typst.py - compiles specified Typst files (its CLI argument is a list of unix pseudo-regexps called file masks)
- compile_latex.py - compiles specified LaTeX files
- compile_md.py - compiles md files 


```
📦ProjectRoot \
 ┣ 📂scripts \
 ┃ ┗ 📜some...\
 ┃ ┗ 📜    implementation... \
 ┃ ┗ 📜                  details... \
 ┃ ┗ 📜                         .py... \
 ┣ 📜 compile_latex.py \
 ┣ 📜 compile_md.py \
 ┣ 📜 compile_typst.py \
 ┣ 📜 commit.py \
 ┣ 📜 deploy.py \
 ┗ 📜 ***some other files...***
```

## Contributing instructions

Let the teachers feel the _force of open-source conspects_!
