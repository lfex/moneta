(defmacro create-table
  ;; One arg: quoted table-name
  (`((,_ . (,table-name . ,_)) . ())
   `(mnta:create-table ,table-name () $ENV))
  ;; Two args: quoted table-name and table-defs list
  (`((,_quote . (,table-name . ,_)) . ((,_quote . ,table-defs)))
   `(mnta:create-table ,table-name ,table-defs $ENV)))

(defun --loaded-moneta-macros-- ()
  "This is just a dummy function for display purposes when including from the
  REPL (the last function loaded has its name printed in stdout).
  This function needs to be the last one in this include."
  'ok)
