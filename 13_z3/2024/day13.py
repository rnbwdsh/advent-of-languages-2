import multiprocessing
import re
from subprocess import Popen, PIPE
from typing import List

import pytest


LEVEL = False


def inner(x1, y1, x2, y2, x, y):
    if LEVEL:
        x += 10000000000000
        y += 10000000000000
    script = f"""(declare-const a Int)
(declare-const b Int)

(assert (>= a 0))
(assert (>= b 0))

(assert (= (+ (* {x1} a) (* {x2} b)) {x}))
(assert (= (+ (* {y1} a) (* {y2} b)) {y}))

(minimize (+ (* 3 a) b))

(check-sat)
(get-model)"""
    p = Popen(['z3', '-in'], stdin=PIPE, stdout=PIPE, stderr=PIPE)
    out, err = p.communicate(script.encode())
    if err:
        print(err.decode())
    if out:
        out = out.decode()
        if out.startswith("sat"):
            a = int(re.search(r"\(define-fun a \(\) Int\s*(\d+)", out).group(1))
            b = int(re.search(r"\(define-fun b \(\) Int\s*(\d+)", out).group(1))
            return a * 3 + b
    return 0


def process_segment(segment):
    pattern = r"Button A: X\+(\d+), Y\+(\d+)\s*Button B: X\+(\d+), Y\+(\d+)\s*Prize: X=(\d+), Y=(\d+)"
    match = re.search(pattern, segment)
    if not match:
        return 0
    return inner(*list(map(int, match.groups())))


@pytest.mark.data("""Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279""", 480, 875318608908)
def test_13(data: List[str], level):
    global LEVEL
    LEVEL = level
    with multiprocessing.Pool() as pool:
        r = sum(pool.map(process_segment, data))
        print(r)
        return r
