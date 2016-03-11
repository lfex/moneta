(defmodule structure
  (export all))

(include-lib "moneta/include/mnt.lfe")
(include-file "examples/tables.lfe")

(defun create-set-tables ()
  `(,(create-table 'employee)
    ,(create-table 'department)
    ,(create-table 'project)
    ,(create-table 'in-department)))

(defun create-bag-tables ()
  `(,(create-table 'manager '(#(type bag)))
    ,(create-table 'in-project '(#(type bag)))))

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
