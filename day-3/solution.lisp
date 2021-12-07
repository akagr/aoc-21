; https://adventofcode.com/2021/day/3

(in-package :advent-of-code/day-3)

(defun max-occurence (list &optional (counter (make-hash-table)))
  "Return item with most frequent occurence in list"
  (if (> (length list) 0)
      (let* ((element (car list))
             (count (gethash element counter 0)))
        (setf (gethash element counter) (+ count 1))
        (max-occurence (cdr list) counter))
      (if (> (gethash 0 counter) (gethash 1 counter))
          0
          1)))

(defun min-occurence (list)
  (if (equal (max-occurence list) 0) 1 0))

(defun distribute (lst)
  (let ((*0* ())
        (*1* ())
        (*2* ())
        (*3* ())
        (*4* ())
        (*5* ())
        (*6* ())
        (*7* ())
        (*8* ())
        (*9* ())
        (*10* ())
        (*11* ()))
    (dolist (binary lst)
      (setq *0* (cons (nth 0 binary) *0*))
      (setq *1* (cons (nth 1 binary) *1*))
      (setq *2* (cons (nth 2 binary) *2*))
      (setq *3* (cons (nth 3 binary) *3*))
      (setq *4* (cons (nth 4 binary) *4*))
      (setq *5* (cons (nth 5 binary) *5*))
      (setq *6* (cons (nth 6 binary) *6*))
      (setq *7* (cons (nth 7 binary) *7*))
      (setq *8* (cons (nth 8 binary) *8*))
      (setq *9* (cons (nth 9 binary) *9*))
      (setq *10* (cons (nth 10 binary) *10*))
      (setq *11* (cons (nth 11 binary) *11*)))
    (list *0* *1* *2* *3* *4* *5* *6* *7* *8* *9* *10* *11*)))

; Answer to First part
(let* ((lists (distribute input))
       (maxes (list (max-occurence (nth 0 lists))
                    (max-occurence (nth 1 lists))
                    (max-occurence (nth 2 lists))
                    (max-occurence (nth 3 lists))
                    (max-occurence (nth 4 lists))
                    (max-occurence (nth 5 lists))
                    (max-occurence (nth 6 lists))
                    (max-occurence (nth 7 lists))
                    (max-occurence (nth 8 lists))
                    (max-occurence (nth 9 lists))
                    (max-occurence (nth 10 lists))
                    (max-occurence (nth 11 lists))))
       (gamma-binary (format nil "~{~A~}" maxes))
       (gamma (parse-integer gamma-binary :radix 2))
       (mins (list  (min-occurence (nth 0 lists))
                    (min-occurence (nth 1 lists))
                    (min-occurence (nth 2 lists))
                    (min-occurence (nth 3 lists))
                    (min-occurence (nth 4 lists))
                    (min-occurence (nth 5 lists))
                    (min-occurence (nth 6 lists))
                    (min-occurence (nth 7 lists))
                    (min-occurence (nth 8 lists))
                    (min-occurence (nth 9 lists))
                    (min-occurence (nth 10 lists))
                    (min-occurence (nth 11 lists))))
       (epsilon-binary (format nil "~{~A~}" mins))
       (epsilon (parse-integer epsilon-binary :radix 2)))
  (* gamma epsilon))

(defun rating-reduce (inp op &optional (index 0))
  (if (= (length inp) 1)
      inp
      (rating-reduce (remove-if #'(lambda (binary)
                             (/= (nth index binary)
                                 (funcall op (nth index (distribute inp)))))
                             inp)
                  op
                  (+ index 1))))

; Answer to second part
(let ((oxygen-rating (parse-integer (format nil "~{~A~}" (car (rating-reduce input 'max-occurence))) :radix 2))
      (carbon-rating (parse-integer (format nil "~{~A~}" (car (rating-reduce input 'min-occurence))) :radix 2)))
  (* oxygen-rating carbon-rating))
