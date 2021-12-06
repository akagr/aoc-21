(in-package :advent-of-code/day-2)

(defun sub-position (commands &optional (x 0) (y 0) (aim 0))
  "Calculate final position of submarine after executing commands"
  (cond ((equal (length commands) 0)
         (list x y))
        (t (let* ((command (car commands))
                  (op (car command))
                  (value (cadr command)))
             (cond ((equal op :forward)
                    (sub-position (cdr commands) (+ x value) (+ y (* value aim)) aim))
                   ((equal op :down)
                    (sub-position (cdr commands) x y (+ aim value)))
                   ((equal op :up)
                    (sub-position (cdr commands) x y (- aim value))))))))

(sub-position input)
