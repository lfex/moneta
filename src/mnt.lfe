(defmodule mnt
  (export all))

(include-lib "moneta/include/mnt.lfe")

(defun create-schema ()
  (mnesia:create_schema `(,(node))))

(defun create-schema
  ((#(start true))
    (create-schema)
    (mnesia:start)))

(defun create-table (name)
  (create-table name '()))
