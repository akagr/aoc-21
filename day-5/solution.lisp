; https://adventofcode.com/2021/day/5

(in-package :advent-of-code/day-5)

(defun x1 (coordinate-pair)
  "Returns x1 from a ((x1 y1) (x2 y2)) coordinate pair"
  (first (first coordinate-pair)))

(defun y1 (coordinate-pair)
  "Returns y1 from a ((x1 y1) (x2 y2)) coordinate pair"
  (second (first coordinate-pair)))

(defun x2 (coordinate-pair)
  "Returns x2 from a ((x1 y1) (x2 y2)) coordinate pair"
  (first (second coordinate-pair)))

(defun y2 (coordinate-pair)
  "Returns y2 from a ((x1 y1) (x2 y2)) coordinate pair"
  (second (second coordinate-pair)))

(defun range-increasing (start end &optional (result ()))
  "Generate a list of numbers from start to end
   Assumes start is always equal or less than end."
  (if (< end start)
      result
      (range-increasing start (- end 1) (cons end result))))

(defun range (v1 v2)
  "Returns an increasing or decreasing range depending on arguments
   Eg: (range 1 3) gives (1 2 3)
       (range 3 1) gives (3 2 1)"
  (if (> v1 v2)
      (reverse (range-increasing v2 v1))
      (range-increasing v1 v2)))

(defvar straights (remove-if #'(lambda (pair)
                                 (and (/= (x1 pair) (x2 pair))
                                      (/= (y1 pair) (y2 pair))))
                             input)
  "Only horizontal or vertical lines from input")

(defun expand (coordinate-pair)
  "Generates complete expansion of coordinate pair.
   Target input only has vertical, horizontal or diagonal (45 degs) lines."
  (let ((x1 (x1 coordinate-pair))
        (x2 (x2 coordinate-pair))
        (y1 (y1 coordinate-pair))
        (y2 (y2 coordinate-pair)))
    (cond ((= x1 x2)
           ;; This is a vertical line
           (mapcar #'(lambda (y) (list x1 y))
                   (range y1 y2)))

          ((= y1 y2)
           ;; This is a horizontal line
           (mapcar #'(lambda (x) (list x y1))
                   (range x1 x2)))

          (t
           ;; This is a diagonal line
           (mapcar #'list
                   (range x1 x2)
                   (range y1 y2))))))

(let ((mapping (make-hash-table :test 'equal))
      (counter 0))
  (dolist (cpair input)
    (dolist (pair (expand cpair))
      (incf (gethash pair mapping 0))))
  (maphash #'(lambda (k v)
               (when (> v 1)
                 (incf counter)))
           mapping)
  counter)
