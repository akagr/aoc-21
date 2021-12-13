; https://adventofcode.com/2021/day/7

(in-package :advent-of-code/day-7)

;; Answer to part 1
(loop
  for num in input
  minimize (loop
             for num2 in input
             sum (abs (- num num2))))

(defun seq-sum (n)
  "Calculate sum of sequence from 1 to n.
   Eg: (seq-sum 5) is equivalent to (+ 1 2 3 4 5)"
  (/ (* n (1+ n)) 2))

;; Answer for part 2
(loop
  for num in input
  minimize (loop
             for num2 in input
             sum (seq-sum (abs (- num num2)))))
