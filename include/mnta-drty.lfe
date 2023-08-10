(eval-when-compile

  (defun get-api-funcs ()
    '((async-dirty 2)
      (dirty-all-keys 1)
      (dirty-delete 1) (dirty-delete 2)
      (dirty-delete-object 1) (dirty-delete-object 2)
      (dirty-first 1)
      (dirty-index-match-object 2) (dirty-index-match-object 3)
      (dirty-index-read 3)
      (dirty-last 1)
      (dirty-match-object 1) (dirty-match-object 2)
      (dirty-next 2)
      (dirty-prev 2)
      (dirty-read 1) (dirty-read 2)
      (dirty-select 2)
      (dirty-slot 2)
      (dirty-update-counter 2) (dirty-update-counter 3)
      (dirty-write 1) (dirty-write 2)
      (sync-dirty 2)))

  ;; end of eval-when-compile
  )

(defmacro generate-api ()
  `(progn ,@(kla:make-funcs (get-api-funcs) 'mnesia)))

(generate-api)

(defun --loaded-mnta-drty-- ()
  "This is just a dummy function for display purposes when including from the
  REPL (the last function loaded has its name printed in stdout).
  This function needs to be the last one in this include."
  'ok)
