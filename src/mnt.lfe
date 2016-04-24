(defmodule mnt
  (export all)
  (export-macro create-table))

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
    ((record-name table-defs)
      `(mnesia:create_table
        ',record-name
        (++ ,table-defs
            (list (tuple 'attributes (mnt-util:get-fields ,record-name))))))))
