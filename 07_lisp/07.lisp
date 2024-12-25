; run with sbcl --script 07.lisp
(declaim (optimize (speed 3) (safety 0) (debug 0)))

(defun consume (total rest expected level)
  (labels ((consume-helper (total rest)
             (cond
               ((null rest) (= total expected))
               (t
                (let ((next (list (+ total (car rest)) (* total (car rest)))))
                  (when (= level 1)
                    (setq next (append next (list (parse-integer (format nil "~A~A" total (car rest)))))))
                  (some (lambda (n) (consume-helper n (cdr rest))) next))))))
    (consume-helper total rest)))

(defun split-string (string delimiter)
  (let ((parts ()))
    (do ((start 0 (1+ end))
         (end (position delimiter string) (position delimiter string :start (1+ end))))
        ((null end) (nreverse (cons (subseq string start) parts)))
      (let ((part (subseq string start end)))
        (unless (string= part "")
          (push part parts))))))

(defun process-line (line level)
  (let* ((parts (split-string line #\:))
         (expected (parse-integer (car parts)))
         (numbers (mapcar #'parse-integer (split-string (cadr parts) #\Space)))
         (first (car numbers))
         (rest (cdr numbers)))
    (consume first rest expected level)))

(defun main (level)
  (let ((total 0))
    (with-open-file (stream "07.in")
      (loop for line = (read-line stream nil)
            while line
            do (let* ((parts (split-string line #\:))
                      (expected (parse-integer (car parts)))
                      (result (process-line line level)))
                 (when result
                   (setq total (+ total expected))))))
    (format t "Part ~A: ~A~%" (if (= level 0) "a" "b") total)))

(main 0)
(main 1)