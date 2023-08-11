(defmodule mnta
  (export all))

(include-lib "lfe/include/clj.lfe")
(include-lib "moneta/include/mnta.lfe")

(defun create-schema ()
  (create-schema (node)))

(defun create-schema
  ((#(start true))
    (create-schema (node) #(start true)))
  ((nodes) (when (is_list nodes))
    (mnesia:create_schema nodes))
  ((node) (when (is_atom node))
    (mnesia:create_schema `(,node))))

(defun create-schema
  ((nodes `#(start true)) (when (is_list nodes))
    (mnesia:create_schema nodes)
    (mnesia:start))
  ((node `#(start true)) (when (is_atom node))
    (mnesia:create_schema `(,node))
    (mnesia:start)))

;;(defmacro create-table args
;;  "To use this macro, pass a 'raw' atom for the table name, not a quoted one --
;;  just like you would do when placing an atom in tuple data: #(...).
;;
;;  You will also need to supply the second parameter: either table definition
;;  data or an empty (unquoted) list.
;;
;;  More specifics:
;;    * whenever an LFE record is created, several macros get created for them;
;;      these macros let you do things like get and set values, but for our
;;      purposes here, we're interested in the (fields-*) macros.
;;    * The (fields-<name>) macro returns the list of fields defined by the
;;      given record. If you have a record named 'employee', then to get that
;;      record's fields, you can call '(fields-employee)'.
;;    * This macro builds the macro name from the given table name (which should
;;      be the same as the record name).
;;    * It then calls the macro with the assembled macro name, assigning it to the
;;      'fields' variable.
;;    * The Mnesia 'create_table' function is then called, passing the table name
;;      as well as the obtained fields."
;;  (case args
;;    ;; Accept a quoted atom
;;    (`(,_ . (,record-name))
;;      `(mnt:create-table ,record-name ()))
;;    ;; Accept a non-quoted atom (usually what gets passed to macros)
;;    (record-name
;;      `(mnt:create-table ,record-name ()))
;;    ;; Accept a quoted atom + quoted empty list
;;    (`(,_ . (,record-name)) `(,_ . '(()))
;;      `(mnt:create-table ,record-name ()))
;;    ;; Accept a non-quoted atom and unquoted empty list
;;    ((record-name '())
;;      `(mnesia:create_table
;;        ',record-name '(#(type set))))
;;    ;; Accept a quoted atom and quoted table definition list
;;    ((`(,_ . (,record-name)) `(,_ . (,table-defs)))
;;      `(mnesia:create_table
;;        ',record-name
;;        (++ ',table-defs
;;            (list (tuple 'attributes (lutil-rec:fields ',record-name))))))
;;    ((record-name table-defs)
;;      `(mnesia:create_table
;;        ',record-name
;;        (++ ',table-defs
;;            (list (tuple 'attributes (lutil-rec:fields ',record-name))))))))

(defun create-table (table-name env)
  "A function version of the create-table macro.

  The same as `(create-table table-name '() env)`.

  Note that since this function calls a table record macro, it requires
  access to the environment where the table macros were compiled."
  (create-table table-name '() env))

(defun create-table (table-name table-opts env)
  "A function version of the create-table macro.

  Note that since this function calls a table record macro, it requires
  access to the environment where the table macros were compiled."
  (->> table-name
       (funcall (lambda (x) `(lutil-rec:fields ,x)))
       (funcall (lambda (x) (eval x env)))
       (tuple 'attributes)
       (list)
       (++ table-opts)
       (mnesia:create_table table-name)))

(defun create-tables (table-names env)
  (create-tables table-names '() env '()))

(defun create-tables (table-names table-opts env)
  (create-tables table-names table-opts env '()))

(defun create-tables
  "A function that creates tables of the same type in one go."
  (('() _ _ results)
   results)
  ((`(,table-name . ,tail-names) table-opts env acc)
   (let ((results (case (create-table table-name table-opts env)
                    ('ok (++ acc `#(ok ,table-name)))
                    (err (++ acc (list err))))))
     (create-tables tail-names table-opts env results))))

(defun tables-info (tables key)
  "Get table metadata for more than one table at once."
  (tables-info tables key '()))

(defun tables-info
  (('() _ results)
   results)
  ((`(,head . ,tail) key acc)
   (tables-info tail key (++ acc (list (table-info head key))))))

;;; Metadata

(defun version ()
  (mnt-vsn:get))

(defun versions ()
  (mnt-vsn:all))