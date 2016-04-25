(defmodule mnt-util
  (export (get-version 0)
          (get-versions 0)
          (make-fields-macro-name 1))
  (export-macro get-fields))

(defun get-version ()
  (lr3-ver-util:get-app-version 'moneta))

(defun get-versions ()
  (++ (lr3-ver-util:get-versions)
      `(#(moneta ,(get-version)))))

(defun make-fields-macro-name (record-name)
  (lutil-type:atom-cat 'fields- record-name))

(defmacro get-fields
  (((cons _ `(,record-name)))
    `(,(make-fields-macro-name `,record-name)))
  ((record-name)
     `(,(make-fields-macro-name record-name))))
