(defun quicksort (lst)
  "Sorts a list of integers using the quicksort algorithm"
  (if (null lst)
      nil
      (let ((pivot (first lst))
            (rest (rest lst)))
        (append (quicksort (remove-if-not #'(lambda (x) (< x pivot)) rest))
                (list pivot)
                (quicksort (remove-if-not #'(lambda (x) (>= x pivot)) rest))))))

(defun parse-string (str)
  "Parses a space-separated string of integers into a list of integers"
  (let* ((num "")
         (digits ()))
    (dotimes (i (length str))
      (let ((char (char str i)))
        (cond ((digit-char-p char) ; digit
               (setf num (concatenate 'string num (string char))))
              ((char= char #\-) ; minus sign
               (setf num (concatenate 'string num (string char))))
              (t ; not a digit or minus sign
               (when (plusp (length num))
                 (setf digits (cons (parse-integer num) digits)
                       num ""))))))
    (when (plusp (length num))
      (setf digits (cons (parse-integer num) digits)))
    (nreverse digits)))

(defun main ()
  "Main function to sort a list of integers using quicksort"
  (format t "Enter a space-separated list of integers: ")
  (let* ((input (read-line))
         (lst (parse-string input))
         (sorted (quicksort lst)))
    (format t "Sorted list: ~a~%" sorted)
    sorted))

(main)

