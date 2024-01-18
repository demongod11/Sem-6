(defvar *address-book* '())

(defun add-contact ()
  (format t "Enter name: ")
  (let ((name (read-line)))
    (format t "Enter the phone number: ")
    (let ((phone (read-line)))
      (format t "Enter the email address: ")
      (let ((email (read-line)))
        (let ((new-contact (list :name name :phone phone :email email)))
          (push new-contact *address-book*)
          (format t "Contact added: ~a~%" new-contact))))))

(defun search-contact ()
  (format t "Enter name to search for: ")
  (let ((name (read-line)))
    (let ((found-contacts (remove-if-not (lambda (c) (string= (getf c :name) name)) *address-book*)))
      (cond ((null found-contacts) (format t "No contacts found with name ~a~%" name))
            ((= (length found-contacts) 1)
             (format t "Name: ~a~%Phone: ~a~%Email: ~a~%" (getf (first found-contacts) :name)
                     (getf (first found-contacts) :phone) (getf (first found-contacts) :email)))
            (t (format t "Multiple contacts found with name ~a:~%~{~a~^,~%~}"
                        name (mapcar (lambda (c) (getf c :phone)) found-contacts)))))))

(defun print-address-book ()
  (dolist (contact *address-book*)
    (format t "Name: ~a~%Phone: ~a~%Email: ~a~%~%" (getf contact :name)
            (getf contact :phone) (getf contact :email))))

(defun main ()
  (format t "1. Add contact~%2. Search contact~%3. Print address book~%")
  (format t "Enter your choice: ")
  (let ((choice (read)))
    (case choice
      (1 (add-contact))
      (2 (search-contact))
      (3 (print-address-book))
      (t (format t "Invalid choice.~%")))))

(loop
  (main))



