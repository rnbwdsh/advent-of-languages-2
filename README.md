# Advent of Languages 2024

This page is inspired by [blu3r4y advent of languages 2020](https://github.com/blu3r4y/AdventOfLanguages2020).

It's a summary of my experience with the advent of code 2024, where I tried to solve every puzzle in a different
programming language.

If you are curious about the git history, I originally did this in
the [advent-of-code-v2](https://github.com/rnbwdsh/advent-of-code-v2/) repository but decided to move it to a separate
project, so this readme is more visible.

## Solutions / Rating

The days numbers link to the python solution — The puzzle names link to the advent of code website — The solution column
links to the according files in this repo.

The ⭐-skill reflects how good I feel I am in the language — The ❤️-like reflects how much I like the language — The (
original release) year is to show how old/modern the language is.

Instructions on how to run these solutions are in the appendix of this file.

|                                                                          Day | Puzzle                                                         | Lang    | Year | Solution                                                    | Skill | Like&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Comment                                                                              |
|-----------------------------------------------------------------------------:|:---------------------------------------------------------------|:--------|:-----|:------------------------------------------------------------|:------------------------|:-----------------------------------------------------------------|--------------------------------------------------------------------------------------|
|  [1](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day01.py) | [Historian Hysteria](https://adventofcode.com/2024/day/1)      | Asm     | 1949 | [01_a.asm](01_asm/01_a.asm)</br>[01_b.asm](01_asm/01_b.asm) | ⭐⭐⚫⚫⚫                   | 🖤🖤🖤🖤🖤                                                       | Very tedious to do number read/write                                                 |
|  [2](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day02.py) | [Red-Nosed Reports](https://adventofcode.com/2024/day/2)       | Bash    | 1989 | [02_a.sh](02_bash/02_a.sh)                                  | ⭐⭐⭐⚫⚫                   | ❤️❤️🖤🖤🖤                                                       | Slow + bad if syntax                                                                 |
|  [3](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day03.py) | [Mull It Over](https://adventofcode.com/2024/day/3)            | AWK     | 1977 | [03_a.awk](03_awk/03_a.awk)</br>[03_b.awk](03_awk/03_b.awk)    | ⭐⭐⚫⚫⚫                   | ❤️❤️❤️❤️❤️                                                       | Feels like a modern language for 1977                                                |
|  [4](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day04.py) | [Ceres Search](https://adventofcode.com/2024/day/4)            | Matlab  | 1984 | [04_a.m](04_matlab/04_a.m)</br>[04_b.m](04_matlab/04_b.m)      | ⭐⚫⚫⚫⚫                   | ❤️🖤🖤🖤🖤                                                       | Slow + offset 1 arrays + cursed array indexing / string to matrix                    |
|  [5](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day05.py) | [Print Queue](https://adventofcode.com/2024/day/5)             | Java    | 1995 | [05.java](05_java/05.java)                                  | ⭐⭐⭐⭐⭐                   | ❤️❤️❤️❤️🖤                                                       | Nearly as verbose as C, but with data structures and safety                          |
|  [6](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day06.py) | [Guard Gallivant](https://adventofcode.com/2024/day/6)         | C       | 1972 | [06.c](06_c/06.c)                                           | ⭐⭐⭐⭐⚫                   | ❤️❤️❤️❤️🖤                                                       | Fast, but easy to make mistakes                                                      |
|  [7](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day07.py) | [Bridge Repair](https://adventofcode.com/2024/day/7)           | Lisp    | 1958 | [07.lisp](07_lisp/07.lisp)                                  | ⭐⚫⚫⚫⚫                   | ❤️🖤🖤🖤🖤                                                       | asm < lisp < c, string split not in stdlib, hard to read/write                       |
|  [8](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day08.py) | [Resonant Collinearity](https://adventofcode.com/2024/day/8)   | SQLite  | 2000 | [08.sqlite.py](08_sqlite/2024/08sqlite.py)                  | ⭐⭐⭐⭐⚫                   | ❤️❤️❤️❤️❤️                                                       | Best SQL dialect for small stuff                                                     |
|  [9](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day09.py) | [Disk Fragmenter](https://adventofcode.com/2024/day/9)         | Go      | 2009 | [09.go](09_go/09.go)                                        | ⭐⭐⭐⚫⚫                   | ❤️❤️❤️❤️❤️                                                       | Like C, but better                                                                   |
| [10](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day10.py) | [Hoof It](https://adventofcode.com/2024/day/10)                | Odin    | 2016 | [10.odin](10_odin/10.odin)                                  | ⭐⚫⚫⚫⚫                   | ❤️❤️❤️❤️🖤                                                       | C < Odin < Go, but nice stdlib                                                       |
| [11](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day11.py) | [Plutonian Pebbles](https://adventofcode.com/2024/day/11)      | F#      | 2005 | [Program.fs](11_fs/Program.fs)                              | ⭐⚫⚫⚫⚫                   | ❤️❤️❤️🖤🖤                                                       | Microsoft Scala, but "if then" and weird map pipe                                    |
| [12](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day12.py) | [Garden Groups](https://adventofcode.com/2024/day/12)          | Fortran | 1957 | [12.f90](12_fortran/12.f90)                                 | ⭐⚫⚫⚫⚫                   | ❤️❤️❤️❤️🖤                                                       | Hyper verbose, everything annotated, C++ with native vectors                         |
| [13](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day13.py) | [Claw Contraption](https://adventofcode.com/2024/day/13)       | Z3      | 2012 | [13.z3](13_z3/13.z3)                                        | ⭐⭐⭐⚫⚫                   | ❤️❤️❤️❤️❤️                                                       | Best SAT solver out there                                                            |
| [14](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day14.py) | [Restroom Redoubt](https://adventofcode.com/2024/day/14)       | Julia   | 2012 | [14.julia](14_julia/14.jl)                                  | ⭐⭐⚫⚫⚫                   | ❤️❤️❤️🖤🖤                                                       | Origin 1, faster python with weird array access                                      |
| [15](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day15.py) | [Warehouse Woes](https://adventofcode.com/2024/day/15)         | Scala   | 2003 | [Main.scala](15_scala/Main.scala)                           | ⭐⭐⭐⭐⚫                   | ❤️❤️❤️❤️🖤                                                       | Better, functional java                                                              |
| [16](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day16.py) | [Reindeer Maze](https://adventofcode.com/2024/day/16)          | Vlang   | 2019 | [16.v](16_vlang/16.v)                                       | ⭐⚫⚫⚫⚫                   | ❤️❤️❤️❤️❤️                                                       | Fast + great syntax, strong competition for nim, more safety                         |
| [17](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day17.py) | [Chronospatial Computer](https://adventofcode.com/2024/day/17) | C++     | 1983 | [day17.cpp](17_c++/17.cpp)                                  | ⭐⭐⭐⚫⚫                   | ❤️❤️❤️❤️❤️                                                       | Good language for a simple brute forcer                                              |
| [18](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day18.py) | [RAM Run](https://adventofcode.com/2024/day/18)                | Ruby    | 1993 | [18.rb](18_ruby/18.rb)                                      | ⭐⭐⚫⚫⚫                   | ❤️❤️❤️❤️🖤                                                       | I liked the [ruby graph lib](https://github.com/monora/rgl) and the syntax is ok     |
| [19](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day19.py) | [Linen Layout](https://adventofcode.com/2024/day/19)           | Rust    | 2015 | [19.rs](19_rust/19.rs)                                      | ⭐⭐⚫⚫⚫                   | ❤️❤️❤️❤️🖤                                                       | Kotlin levels of convenient/concise, C-Levels of fast, sometimes weird safety        |
| [20](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day20.py) | [Race Condition](https://adventofcode.com/2024/day/20)         | JS      | 2016 | [20.js](20_js/20.js)                                        | ⭐⭐⭐⭐⚫                   | ❤️❤️❤️❤️🖤                                                       | Good language, except for Map/Object keys can't be tuples, some quirks               |
| [21](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day21.py) | [Keypad Conundrum](https://adventofcode.com/2024/day/21)       | Kotlin  | 2011 | [21.kt](21_kotlin/21.kt)                                    | ⭐⭐⭐⭐⚫                   | ❤️❤️❤️❤️❤️                                                       | Simply better java, for oop problems better than py                                  |
| [22](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day22.py) | [Monkey Market](https://adventofcode.com/2024/day/22)          | Nim     | 2008 | [day22.nim](22_nim/day22.nim)                               | ⭐⭐⭐⭐⚫                   | ❤️❤️❤️❤️❤️                                                       | Great language, multiprocessing and slicing can be somewhat weird                    |
| [23](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day23.py) | [LAN Party](https://adventofcode.com/2024/day/23)              | C#      | 2000 | [Program.cs](23_cs/Program.cs)                              | ⭐⭐⚫⚫⚫                   | ❤️❤️❤️🖤🖤                                                       | Microsoft Java with capitalized methods and weird brackets                           |
| [24](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day24.py) | [Crossed Wires](https://adventofcode.com/2024/day/24)          | Lua     | 1993 | [24.lua](24_lua/24.lua)                                     | ⭐⚫⚫⚫⚫                   | ❤️❤️🖤🖤🖤                                                       | Rather bad, untypical semantics coming from C/Java/py                                |
| [25](https://github.com/rnbwdsh/advent-of-code-v2/tree/master/2024/day25.py) | [Code Chronicle](https://adventofcode.com/2024/day/25)         | Perl    | 1987 | [25.pl](25_perl/25.pl)                                      | ⭐⚫⚫⚫⚫                   | ❤️🖤🖤🖤🖤                                                       | Horrible semantics without compile-time checks, stupid $/@ variable prefix, just bad |

## Used languages

I'd categorize them into the following groups, based on my Java/C/Python background, ranked by preference of the
category:

| Category                | Comment                                                                      | Language                              |
|-------------------------|------------------------------------------------------------------------------|---------------------------------------|
| Bad DSLs                | I'd rather use a general purpose modern language                             | Matlab < AWK                          |
| Bad oldschool languages | Bad tedious syntax, better modern options exist, reading and writing is pain | Assembly < Lisp                       |
| Bad scripting languages | Interpreted, slow, weird syntax like end-blocks                              | Perl < Lua < Bash < Ruby < Julia < JS |
| C's                     | Oldschool, small stdlib, compiled, fast                                      | C++ < C < Go                          |
| Modern C's              | C, but with a better stdlib and some syntax sugar                            | Rust < Odin                           |
| Javas                   | OOP, strongly typed, big stdlib, compiled, fast                              | C# < Java < Scala < F# < Kotlin       |
| Good DSLs               | Essentially the only sane option to do a thing they are good at              | Fortran < SQL < Z3                    |
| Good modern languages   | Strong types, pythonic syntax, compile time checking, fast, great dx         | Vlang < NIM                           |

Prior experience with languages:

* some: (Java, Go, Kotlin, C, Javascript, Z3, Sqlite, Nim)
* rarely: (Rust, Bash, Awk, C#, Ruby, C++, Assembly, Lisp, Scala)
* never: (Fortran, Vlang, Julia, Odin, F#, Matlab, Perl, Lua)

## Languages not used

| Category           | Comment                                                                                                                                            |
|--------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| Python / *ython    | The plan was to pre-code in python and then rewrite in another language, so I didn't use any pythons.                                              |
| Groovy, PHP        | Used before, backup languages I already know but didn't need.                                                                                      |
| Zig, Haxe          | Intellij integration didn't work for me (IDEA 2023.2.2)                                                                                            |
| Mojo, crystal, D   | Looked cool, maybe next year.                                                                                                                      |
| Delphi, COBOL      | Even basic tutorials and getting them to run / ide integrated looked horrible.                                                                     |
| J, K, APL, Haskell | There weren't any examples that were super functional-friendly and the learning curve for hyperfunctional languages is too steep for a single day. |
| Erlang, Elixir     | Looked cool for highly parallelizable problems                                                                                                     |

## Effort, time and ai tools

### Python program effort

* For 12 days, I needed ~10 minutes or less for both levels - mostly the early levels, level 18+19+25.
* For 8 days, I needed 30-60 minutes for both levels.
* Day 15 - the box pushing puzzle, I needed, I struggled for 2h.
* Day 17 - the quine input puzzle, it took me roughly 3h and a small 1h break - to realize that it's a classic z3
  problem.
* Day 20 - the racetrack cheating puzzle, it took me a lot of reverse engineering from the example outputs to fully
  undertand the puzzle. I wasn't sure till the end, if a "glitch" must start at a road-wall transition and end at a
  wall-road transition - or if we effectively double-count a lot of shortcuts.
* Day 21 - the keypad puzzle, it took me another 4h and multiple breaks to figure out it's a recursive tree problem. It
  took em ~1h to go from a recursive tree to the 3 lines of reduction code.
* Day 24 - the broken adder, took me around 3h to do semi-manually, by checking if the adder was broken up to a certain
  point with some asserts. The rewrite to do it semi-dynamically was another 1h.

For most examples, I also had to do another 30 minutes or so of code-cleanup with the help of deepseek coder, to remove
a lot of intermediate throwaway code and make the code as concise as possible. This was helpful for the rewrite in
another language.

In total, it was probably around 30-40h of effort, with 50% of the effort spent on the 5 hard levels.

### New language effort

The setup and rewrite in another language ranged from 10 minutes to 3h with an average of 1.5h.

* The assembly rewrite took ~3h, with an intermediate step of rewriting to C first.
* The lisp rewrite took 2h with a lot of help from deepseek coder and I already have no idea what I did.
* Lua, perl and bash took 2h each because a lot of stuff didn't work as expected / printf debugging. I didn't even do
  part b because it was such a bad experience.
* The vlang rewrite took ~2h because the original python code used networkx - so I had to rewrite a dikstra.
* Most strongly typed, oop languages like Java, Rust, Go, Nim took 1.5h but the experience was pretty good due to C-like
  syntax and good intellisense / copilot completions.
* Ruby, Scala, C# and Odin took ~1h, as they were rather similar to python, java and go.
* The C++ rewrite was just 1h, but it's not a general solution but just a solution that works for my input and uses the
  fast execution speed for better brute force.
* The sqlite and the z3 rewrite were 30 minutes, as they were really close to my original python code and the wrappers
  to do
  the IO/data parsing were written in python.
* The matlab and julia rewrites were 1h, even though the resulting programs are rather short - but I had to look up
  nearly every function.
* On top of the javascript solution for the pretty day20, I spent another 2h to write some HTML and CSS to visualize it.
  It even got some
  upvotes [on reddit](https://www.reddit.com/r/adventofcode/comments/1hijjpl/2024_day_20_htmljs_visualizer/). You can
  try it at [https://öä.eu/aoc2420](https://öä.eu/aoc2420)

In total, the advent of languages was another 30-40h of effort, with a more even distribution of effort. For very
tedious levels or languages, I skipped the b-part.

### AI tools

Github copilot (line completion in intellij) were extremely helpful. I also tried tabnine for a bit,
as my github copilot license ran out - and it's 90% as good as copilot for free.

For questions / explanations, I nearly exclusively moved to deepseek coder over chatgpt / claude, especially the "deep
think" r1 feature
that rivals chatgpt o1 was extremely powerful. And fast. And free. And had a nice interface.
I even used it for a lot of tedious tasks like writing the table above and the run-instructions below, as well as
double-checking this readme.

## Learnings and conclusion

### The good

From the new languages I tried, I'd say vlang and fortran were the most surprisingly good.

The strong typing of fortran seems like a good option for pytorch/numpy alike stuff and I fully understand why numpy is
written in fortran and why fortran-CUDA bindings exist. I expected to language to be as tedious as cobol or delphi,
based
on how old it is.

Vlang seems to be similar to nim - which I already like a lot.

Odin and Rust seemed like great alternatives to C, but I'd still use Nim or Go over it.

Generally, python (optionally with numba or parallelism) was pretty fast / fast enough for most problems.

### The bad

Most old programming languages I tried like lua and perl were worse than expected, a lot of "normal things" like objects
are just plain weird to the degree of modifying python dunder-methods.

Matlab/octave and julia were significantly slower than python, so I don't see a reason to use them.

I also rediscovered my hate for assembly, bash and lisp. I think learning crystal, elixir or any of the modern
functional languages would have been more fun.

## Appendix: How to run the solutions

These script boxes should have a run button in IntelliJ IDEA. All the languages are installable via pacman/aur.

### Day 01 - Assembly

```bash
cd 01_asm
aocd 1 2024 > 01.in
# Part A
nasm -f elf64 -g -F dwarf -o 01_a.o 01_a.asm
gcc -no-pie -o 01_a 01_a.o -lc -g
./01_a

# Part B
nasm -f elf64 -g -F dwarf -o 01_b.o 01_b.asm
gcc -no-pie -o 01_b 01_b.o -lc -g
./01_b
rm 01_a 01_a.o 01_b 01_b.o
```

### Day 02 - Bash

```bash
cd 02_bash
aocd 2 2024 > 02.in
sh 02_a.sh
```

### Day 03 - AWK

```bash
cd 03_awk
aocd 3 2024 > 03.in
awk -v RS= -f 03_a.awk 03.in
awk -v RS= -f 03_b.awk 03.in
```

### Day 04 - MATLAB (Octave)

```bash
cd 04_matlab
aocd 4 2024 > 04.in
octave 04_a.m
octave 04_b.m
```

### Day 05 - Java

```bash
cd 05_java
aocd 5 2024 > 05.in
java 05.java
```

### Day 06 - C

```bash
cd 06_c
aocd 6 2024 > 06.in
gcc -o 06 06.c
./06
rm 06
```

### Day 07 - Lisp (SBCL)

```bash
cd 07_lisp
aocd 7 2024 > 07.in
sbcl --script 07.lisp
```

### Day 08 - SQLite

```bash
cd 08_sqlite
pytest 2024/08sqlite.py
```

### Day 09 - Go

```bash
cd 09_go
aocd 9 2024 > 09.in
go run 09.go
```

### Day 10 - Odin

```bash
cd 10_odin
aocd 10 2024 > 10.in
odin run 10.odin -file
```

### Day 11 - F#

```bash
cd 11_fs
dotnet run --project 11_fs.fsproj
rm -rf bin obj
```

### Day 12 - Fortran

```bash
cd 12_fortran
aocd 12 2024 > 12.in
gfortran -o 12 12.f90
./12
rm 12
```

### Day 13 - Z3

```bash
cd 13_z3
aocd 13 2024 > 13.in
z3 13.z3
pytest 2024/day13.py
```

### Day 14 - Julia

```bash
cd 14_julia
aocd 14 2024 > 14.in
julia 14.jl
```

### Day 15 - Scala

```bash
cd 15_scala
aocd 15 2024 > 15.in
scalac Main.scala
scala Main
rm Main.class Main$.class Solver.class
```

### Day 16 - Vlang

```bash
cd 16_vlang
aocd 16 2024 > 16.in
v run 16.v
```

### Day 17 - C++

```bash
cd 17_c++
g++ -o 17 -O3 17.cpp
./17
rm 17
```

### Day 18 - Ruby

```bash
cd 18_ruby
aocd 18 2024 > 18.in
ruby 18.rb
```

### Day 19 - Rust

```bash
cd 19_rust
aocd 19 2024 > 19.in
rustc 19.rs
./19    
rm 19
```

### Day 20 - JavaScript

```bash
cd 20_js
aocd 20 2024 > 20.in
node 20.js
```

### Day 21 - Kotlin

```bash
cd 21_kotlin
aocd 21 2024 > 21.in
kotlinc 21.kt -include-runtime -d 21.jar
java -jar 21.jar
rm 21.jar
```

### Day 22 - Nim

```bash
cd 22_nim
aocd 22 2024 > 22.in
nim c -d:release day22.nim
./day22
rm day22
```

### Day 23 - C#

```bash
cd 23_cs
aocd 23 2024 > 23.in
dotnet run --project day23.csproj
rm -rf bin obj
```

### Day 24 - Lua

```bash
cd 24_lua
aocd 24 2024 > 24.in
lua 24.lua
```

### Day 25 - Perl5

```bash
cd 25_perl
aocd 25 2024 > 25.in
perl 25.pl
```