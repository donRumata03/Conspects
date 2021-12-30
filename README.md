# Conspects && useful resources
ITMO CT M3138 useful resources including:

- _**Conspects**_
- Related books
- Links to recorded lections at youtube
- HomeTasks

## Supported subjects

- [Algorithms and data structures](Analgorithms)
- [Mathematical analysis](MathAnal)
- [Discrete Mathematics](DICKreteMath)
- [Computer architecture](CUMputerAAAAAAAAH)
- [Linear algebra](LinAnalgebra)

## Awaited subjects:
- FuckToAnal Programming

## Brief technical description 


            
    

          

There are two major conspect formats:
- LaTeX
- Markdown

both of them are compiled to pdf.

Latex is — through XeLaTeX compiler (its killer features were modern font support (vs. pdfLaTeX) and relatively fast compilation compared to LuaLaTeX).
And .md files are compiled to pdf by [pandoc](https://pandoc.org/).

But, unfortunately, these tools require: too much command line arguments and escaping characters, clearing temp files, providing temp files and many other additional procedures.
[latexmk](https://mg.readthedocs.io/latexmk.html) partially solves the issues, but still leaves much to be desired.

To automate those actions there are some scripts written within the framework of this repo.
Moreover, the scripts are also capable of detecting you changes (using Git API), 
committing them with proper commit messages and splitting the changes between commits wisely.


## Requierd tools' installation

- Insure you have a working latex distribution. The mainstream options are: tex-live for Linux && MacOS and MikTex for Windows.
  Note that MikTex automatically installs all required packages at compilation while tex-live requiers them to be pre-downloaded by `tlmgr` (tex-live manager) utility.
  If you experience problems with `tlmgr`'s work, visit [this page](https://tex.stackexchange.com/questions/540429/tlmgr-in-ubuntu-20-04-local-tex-live-2019-is-older-than-remote-repository-2).
  So, to compile everything successfully with tex-live, 
- Install font pack from directory `Fonts/Kurale`
- Install latexmk (via package manager on Linux or from binaries. In the second case — don't forget to install perl before…)
- Install an IDE for efficient work with latex (I've recently switched to Visual Studio Code from Texify Idea. It's a bit less clever but offers some tasty features…)
- To compile Markdown to pdf from console you also need to install pandoc. There are should not be any pitfalls…
- For editing Markdown files I recommend [Typora - a truly minimal markdown editor](https://typora.io/).
  As well as pandoc, typora supports something called «enriched markdown» (my own term).
  But it's much more convenient to edit md conspects in typora but compile through pandoc. 
  Unfortunately, «enriched markdowns» are a bit different and not fully compatible, 
  so you probably need to make sure that you files are maintained compilable…


## Building with scripts

Now, when all the desired software is installed, it's time to get used to python scripts for common operations with conspects.

What are scripts responsible for:
- Compile LaTeX source code to PDFs with special settings (latexmk; xelatex)
- Compile Markdown source code to PDFs with special settings
- Track changes using git api
- Distributing changes between commits smartly
- Commit naming based on folders in which the changes were made
- Fully automatically perform the actions above and run ``git push`` after that.

Those things can drastically boost your performance at writing electronic conspects.

Basically, typical workflow is as following:
- Write some code in latex editor. Optionally - use its recompiling-on-fly features.
- Just run python script ``./deploy.py``. It will:
  - Compile changed conspect source files
  - For each committing group - ``git add`` it; 
    ``commit`` with respective message;
  - ``git push`` the commits to ``origin/master`` branch

> Stop those stupid attempts of renaming ``master`` branch to ``main``!
> The master will finally punish such naughty slaves!

At the moment there are the following script files intended for simplifying 
everyday conspectors' activities:

- deploy.py - description's already provided above
- commit.py - is responsible for all `deploy`'s work except running `git push`
- compile_latex.py - compiles specified LaTeX files
- compile_latex.py - compiles 


```
📦ProjectRoot \
 ┣ 📂scripts \
 ┃ ┗ 📜some...\
 ┃ ┗ 📜    implementation... \
 ┃ ┗ 📜                  details... \
 ┃ ┗ 📜                         .py... \
 ┣ 📜 compile_md.py \
 ┣ 📜 compile_latex.py \
 ┣ 📜 commit.py \
 ┣ 📜 deploy.py \
 ┗ 📜 ***some other files...***
```

## Contributing instructions

Let the teachers feel the _force of open-source conspects_!
