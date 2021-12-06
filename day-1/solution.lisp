; Advent of Code
; --- Day 1: Sonar Sweep ---
; https://adventofcode.com/2021/day/1

(in-package :advent-of-code/day-1)

(defun count-increasing (list &optional head (count 0))
  "Count items that are greater than previous item in the list"
  (cond ((not head)
         (count-increasing (cdr list) (car list) count))
        ((<= (length list) 0)
         count)
        ((>= head (car list))
         (count-increasing (cdr list) (car list) count))
        ((< head (car list))
         (count-increasing (cdr list) (car list) (+ count 1)))))

; Answer for first part
(count-increasing input)

(defun threes (list &optional (result ()))
  "Breaks up a list of numbers in groups of threes.
   Eg: (threes '(1 2 3 4)) returns '((1 2 3) (2 3 4))

   Note: Lists with fewer than 3 numbers result in NIL."
  (cond ((>= (length list) 3)
         (threes (cdr list)
                 (cons (list (nth 0 list)
                             (nth 1 list)
                             (nth 2 list))
                       result)))
        (t (reverse result))))

; Answer for second part
(let ((sums (mapcar #'(lambda (triplet)
                            (apply '+ triplet))
                        (threes input))))
  (count-increasing sums))
