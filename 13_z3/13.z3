(declare-const a Int)
(declare-const b Int)

(assert (>= a 0))
(assert (>= b 0))

(assert (= (+ (* 94 a) (* 22 b)) 8400))
(assert (= (+ (* 34 a) (* 67 b)) 5400))

(minimize (+ (* 3 a) b))

(check-sat)
(get-model)