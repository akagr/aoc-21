; https://adventofcode.com/2021/day/4

(in-package :advent-of-code/day-4)

(defun columns (grid &optional (cols (list () () () () ())))
  "Returns list of columns in a grid"
  (if (= 0 (length grid))
      cols
      (let ((row (car grid)))
        (dotimes (i 5)
          (setf (nth i cols)
                (cons (nth i row)
                      (nth i cols))))
        (columns (cdr grid) cols))))

(defun flatten (list)
  (apply #'append list))

(defun memberp (item list)
  (numberp (position item list)))

(defun matchp (row-or-col moves)
  "Checks if all elements in row-or-col are present in moves"
  (or (= (length row-or-col) 0)
      (and (memberp (car row-or-col) moves)
           (matchp (cdr row-or-col) moves))))

(defun match-grid-p (rows moves)
  "Checks if at least one row or column of a grid are matched by moves"
  (let ((cols (columns rows))
        (match-moves-p (lambda (row-or-col) (matchp row-or-col moves))))
    (or (some match-moves-p rows)
        (some match-moves-p cols))))

;; Solution for #1
(defun play-bingo (grids moves remaining-moves)
  (let ((winner (find-if #'(lambda (grid) (match-grid-p grid moves)) grids)))
    (if winner
        (* (car moves)
           (apply #'+ (remove-if #'(lambda (n) (memberp n moves))
                                 (flatten winner))))
        (play-bingo grids
                    (cons (car remaining-moves) moves)
                    (cdr remaining-moves)))))

(play-bingo input/grids () input/moves)

;; Solution for #2
(defun play-bingo-2 (grids winners moves remaining-moves)
  (cond ((= (length grids) 0)
         (* (car moves)
            (apply #'+ (remove-if #'(lambda (n) (memberp n moves))
                                  (flatten (car winners))))))

        ((= (length remaining-moves) 0)
         (let* ((last-winner (car winners))
                (winning-move (find-if #'(lambda (x)
                                              (memberp x (flatten last-winner)))
                                          moves))
                (moves-upto-winning (member winning-move moves)))
           (* winning-move
              (apply #'+ (remove-if #'(lambda (n)
                                        (memberp n moves-upto-winning))
                                    (flatten last-winner))))))
        (t
         (let ((winner (find-if #'(lambda (grid) (match-grid-p grid moves)) grids)))
           (if winner
               ;; Until winner keeps getting found for current moves, we keep
               ;; re-running this same function.
               (play-bingo-2 (remove winner grids)
                             (cons winner winners)
                             moves
                             remaining-moves)
               (play-bingo-2 grids
                             winners
                             (cons (car remaining-moves) moves)
                             (cdr remaining-moves)))))))

(play-bingo-2 input/grids () () input/moves)
