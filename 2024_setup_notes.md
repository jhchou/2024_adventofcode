# Advent of Code 2024

Registered 2024 with GitHub (jhchou)

* [Advent of Code](https://adventofcode.com/)
* [Julialang private leaderboard](https://adventofcode.com/2021/leaderboard/private/view/??????)

## Setup GitHub

* created new repository on GitHub (public, NO README.md)
* created new local folder --> Terminal --> cd

```
echo "# 2024_adventofcode" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/jhchou/2024_adventofcode.git
git push -u origin main
```

GitHub authentication -- password no longer works, need to generate a Personal Access Token

- GitHub: profile photo --> Settings --> Developer settings (at bottom) --> Personal access tokens --> Fine-grained tokens
- Generate new token --> token name 2024_adventofcode --> only select repos --> repo permissions --> Contents --> Read & Write


## VS code

* Open `2024_adventofcode` folder in VS code
* _(DID NOT DO: `Jupyter: Create New Jupyter Notebook`)_
* `Cmd-Shift-P` --> `Julia: Start REPL`
    * versioninfo() # confirm using v1.11.1
    * start with empty environment
    * `]` # package manager
    * `status`
    * `activate .` (use its own project environment)
    * `add DataStructures` (consider OffsetArrays, Combinatorics, AStarSearch, BenchmarkTools, DelimitedFiles)




## To do: Data

* separate script used to pull all data for all years
* copy into `data` folder
