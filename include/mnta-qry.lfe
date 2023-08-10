(eval-when-compile

  (defun get-api-funcs ()
    '((append 1) (append 2)
      (cursor 1) (cursor 2)
      (delete-cursor 1)
      (eval 1) (eval 2)
      (e 1) (e 2)
      (fold 3) (fold 4)
      (format-error 1)
      (info 1) (info 2)
      (keysort 2) (keysort 3)
      (next-answers 1) (next-answers 2)
      (q 1) (q 2)
      (sort 1) (sort 2)
      (string-to-handle 1) (string-to-handle 2) (string-to-handle 3)
      (table 2)))

  ;; end of eval-when-compile)
  )

(defmacro generate-api ()
  `(progn ,@(kla:make-funcs (get-api-funcs) 'qlc)))

(generate-api)

(defun --loaded-mnta-qry-- ()
  "This is just a dummy function for display purposes when including from the
  REPL (the last function loaded has its name printed in stdout).
  This function needs to be the last one in this include."
  'ok)
