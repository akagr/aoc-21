; https://adventofcode.com/2021/day/6

(in-package :advent-of-code/day-6)

(defvar fish-count
  (let ((population (make-sequence 'list 9 :initial-element 0)))
    (dolist (fish input population)
      (incf (nth fish population))))
  "Map individual fish to a count list. Element at each index
   represents number of fish which will be ready for giving birth
   in that many days.

   Eg: if population[5] = 60, that means we have 60 fishes
   which are 5 days from giving birth.")

(defun live-for-1-day (population)
  "A day's worth of changes in population"
  (let ((ready-new (nth 0 population)))
    (rotatef (nth 0 population)
             (nth 1 population)
             (nth 2 population)
             (nth 3 population)
             (nth 4 population)
             (nth 5 population)
             (nth 6 population)
             (nth 7 population)
             (nth 8 population))
    ;; Because existing fish restart from day 6 instead of
    ;; 8, adding to 6 essentially rotates 0 -> 6 too, while
    ;; accounting for any fish rolling in from day 7.
    (incf (nth 6 population) ready-new)
    population))

(defun live-for (days population)
  (if (<= days 0)
      population
      (live-for (1- days) (live-for-1-day population))))

(defun count-population-after (&key days)
  (let ((population (make-sequence 'list 9 :initial-element 0)))
    (dolist (fish input population)
      (incf (nth fish population)))
    (apply #'+ (live-for days population))))

;; Answer for first part
(count-population-after :days 80)

;; Answer for second part
(count-population-after :days 256)
