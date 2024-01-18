(defvar *address-book* '())

(defun add-a-contact ()
  (format t "Enter the name: ")
  (let ((name (read-line)))
    (format t "Enter the phone number: ")
    (let ((phone (read-line)))
      (format t "Enter the email address: ")
      (let ((email (read-line)))
        (let ((a-contact (list :name name :number phone :emailid email)))
          (push a-contact *address-book*)
          (format t "Added the contact: ~a~%" a-contact))))))

(defun search-a-contact ()
  (format t "Enter a name to search : ")
  (let ((name (read-line)))
    (let ((found-contacts (remove-if-not (lambda (c) (string= (getf c :name) name)) *address-book*)))
      (cond ((null found-contacts) (format t "No contacts are there with the name ~a~% !" name))
            ((= (length found-contacts) 1)
             (format t "Name: ~a~%Phone Number: ~a~%Email Address: ~a~%"
                     (getf (first found-contacts) :name)
                     (getf (first found-contacts) :number)
                     (getf (first found-contacts) :emailid)))
            (t (format t "Multiple contacts present with name ~a:~%~{Name: ~a~%Phone Number: ~a~%Email Address: ~a~%~}"
                        name (mapcar (lambda (c)
                                      (list (getf c :name) (getf c :number) (getf c :emailid)))
                                    found-contacts)))))))



(defun print-the-address-book ()
  (dolist (contact *address-book*)
    (format t "Name: ~a~%Phone Number: ~a~%Email Address: ~a~%~%" (getf contact :name)
            (getf contact :number) (getf contact :emailid))))

(defun main ()
  (format t "1. Add a contact~%2. Search a contact~%3. Print the address book~%")
  (format t "Choose an operation to perform: ")
  (let ((choose (read)))
    (case choose
      (1 (add-a-contact))
      (2 (search-a-contact))
      (3 (print-the-address-book))
      (t (format t "Pick an option amoung 1, 2, 3 only!.~%")))))

(loop
  (main))
