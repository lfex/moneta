(defmodule mnta-qry
  (export all))

(include-lib "moneta/include/mnta-qry.lfe")

(defun show-data (table-name)
  (mnesia:transaction
    (lambda ()
      (mnesia:foldl
        (lambda (x _) (lfe_io:format '"~p~n" (list x)))
        0
        table-name))))
