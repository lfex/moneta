(defmodule mnt
  (export all)
  (export-macro create-table
                create-tables))

(include-lib "clj/include/compose.lfe")
(include-lib "moneta/include/mnt.lfe")

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
  ((nodes #(start true)) (when (is_list nodes))
    (mnesia:create_schema nodes)
    (mnesia:start))
  ((node #(start true)) (when (is_atom node))
    (mnesia:create_schema `(,node))
    (mnesia:start)))

(defmacro create-table args
  "To use this macro, pass a 'raw' atom for the table name, not a quoted one --
  just like you would do when placing an atom in tuple data: #(...).

  You will also need to supply the second parameter: either table definition
  data or an empty (unquoted) list.

  More specifics:
    * whenever an LFE record is created, several macros get created for them;
      these macros let you do things like get and set values, but for our
      purposes here, we're interested in the (fields-*) macros.
    * The (fields-<name>) macro returns the list of fields defined by the
      given record. If you have a record named 'employee', then to get that
      record's fields, you can call '(fields-employee)'.
    * This macro builds the macro name from the given table name (which should
      be the same as the record name).
    * It then calls the macro with the assembled macro name, assigning it to the
      'fields' variable.
    * The Mnesia 'create_table' function is then called, passing the table name
      as well as the obtained fields."
  (case args
    ;; Accept a quoted atom
    (((cons _ `(,record-name)))
      `(mnt:create-table ,record-name ()))
    ;; Accept a non-quoted atom (usually what gets passed to macros)
    ((record-name)
      `(mnt:create-table ,record-name ()))
    ;; Accept a quoted atom + quoted empty list
    (((cons _ `(,record-name)) (cons _ (())))
      `(mnt:create-table ,record-name ()))
    ;; Accept a non-quoted atom and unquoted empty list
    ((record-name '())
      `(mnesia:create_table
        ',record-name '(#(type set))))
    ;; Accept a quoted atom and quoted table definition list
    (((cons _ `(,record-name)) (cons _ `(,table-defs)))
      `(mnesia:create_table
        ',record-name
        (++ ',table-defs
            (list (tuple 'attributes (mnt-util:get-fields ',record-name))))))
    ((record-name table-defs)
      `(mnesia:create_table
        ',record-name
        (++ ',table-defs
            (list (tuple 'attributes (mnt-util:get-fields ',record-name))))))))

(defun create-table-env (table-name env)
  "A function version of the create-table macro.

  The same as ``(create-table-env table-name '() env)``.

  Note that since this function calls a table record macro, it requires
  access to the environment where the table macros were compiled."
  (create-table-env table-name '() env))

(defun create-table-env (table-name table-defs env)
  "A function version of the create-table macro.

  Note that since this function calls a table record macro, it requires
  access to the environment where the table macros were compiled."
  (->> table-name
       (funcall (lambda (x) `(mnt-util:get-fields ,x)))
       (funcall (lambda (x) (eval x env)))
       (tuple 'attributes)
       (list)
       (++ table-defs)
       (mnesia:create_table table-name)))

(defun create-tables-env (table-names env)
  "A function that creates tables of the same type in one go.

  The same as ``(create-tables-env table-names '() env)``."
  (create-tables-env table-names '() env))

(defun create-tables-env (table-names table-defs env)
  "A function that creates tables of the same type in one go."
  (lists:map (lambda (x)
               (mnt:create-table-env x table-defs env))
             table-names))

(defmacro create-tables (table-names table-defs)
  "A macro-version of the ``#create-tables-env/2,3`` that automatically
  provides the executing environment."
  `(mnt:create-tables-env ,table-names ,table-defs $ENV))

(defun tables-info (table-names key)
  "Get table metadata for more than one table at once."
  (lists:map (lambda (x) (mnt:table-info x key)) table-names))
