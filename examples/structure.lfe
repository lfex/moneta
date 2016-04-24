(defmodule structure
  (export all))

(include-file "examples/tables.lfe")

(defun create-set-tables ()
  `(,(mnt:create-table 'employee)
    ,(mnt:create-table 'department)
    ,(mnt:create-table 'project)
    ,(mnt:create-table 'in-department)))

(defun create-bag-tables ()
  `(,(mnt:create-table 'manager '(#(type bag)))
    ,(mnt:create-table 'in-project '(#(type bag)))))

(defun get-status (list-of-tuples)
  (case (lists:dropwhile (lambda (x) (== (element 2 x) 'ok))
                         list-of-tuples)
    ('() 'ok)
    (_ 'error)))

(defun init ()
  (let* ((sets (create-set-tables))
         (bags (create-bag-tables))
         (status (get-status (++ sets bags))))
    `#(,status
       (#(create-set-tables ,sets)
        #(create-bag-tables ,bags)))))
