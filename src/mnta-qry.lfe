(defmodule mnta-qry
  (export
   (insert 1) (insert 2)
   (select-all 1)))

(include-lib "moneta/include/mnta-qry.lfe")

(defun insert (record)
  (insert record 'undefined))

(defun insert
  (('() _)
   'ok)
  ((record func) (when (is_tuple record))
   (insert (list record) func))
  ((`(,record . ,tail) func)
   (insert-one record func)
   (insert tail)))

(defun select-all (table-name)
  (mnesia:transaction
    (lambda ()
      (mnesia:foldl
        (lambda (x acc) (++ acc (list x)))
        '()
        table-name))))

;;; Private functions

(defun insert-one (record func)
  (mnesia:transaction
   (lambda ()
     (mnesia:write record)
     (if (not (== func 'undefined))
       (funcall func record)))))
