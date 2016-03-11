(defmodule mnt-qry
  (export all))

(include-lib "moneta/include/mnt-qry.lfe")

(defun show-data (table-name)
  (mnesia:transaction
    (lambda ()
      (mnesia:foldl
        (lambda (x _) (lfe_io:format '"~p~n" (list x)))
        0
        table-name))))
