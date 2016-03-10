(defmodule mnt-drty
  (export all))

(include-lib "moneta/include/mnt-drty.lfe")

(defun async (a b)
  (async-dirty a b))

(defun sync (a b)
  (sync-dirty a b))

(defun all-keys (a)
  (dirty-all-keys a))

(defun delete (a)
  (dirty-delete a))

(defun delete (a b)
  (dirty-delete a b))

(defun delete-object (a)
  (dirty-delete-object a))

(defun delete-object (a b)
  (dirty-delete-object a b))

(defun first (a)
  (dirty-first a))

(defun index-match-object (a b)
  (dirty-index-match-object a b))

(defun index-match-object (a b c)
  (dirty-index-match-object a b c))

(defun index-read (a b c)
  (dirty-index-read a b c))

(defun last (a)
  (dirty-last a))

(defun match-object (a)
  (dirty-match-object a))

(defun match-object (a b)
  (dirty-match-object a b))

(defun next (a b)
  (dirty-next a b))

(defun prev (a b)
  (dirty-prev a b))

(defun read (a)
  (dirty-read a))

(defun read (a b)
  (dirty-read a b))

(defun select (a b)
  (dirty-select a b))

(defun slot (a b)
  (dirty-slot a b))

(defun update-counter (a b)
  (dirty-update-counter a b))

(defun update-counter (a b c)
  (dirty-update-counter a b c))

(defun write (a)
  (dirty-write a))

(defun write (a b)
  (dirty-write a b))
