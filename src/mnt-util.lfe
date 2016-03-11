(defmodule mnt-util
  (export (get-version 0)
          (get-versions 0)
          (make-fields-macro-name 1))
  (export-macro get-fields))

(defun get-version ()
  (lutil:get-app-version 'moneta))

(defun get-versions ()
  (++ (lutil:get-versions)
      `(#(moneta ,(get-version)))))

(defun make-fields-macro-name (record-name)
  (lutil-type:atom-cat 'fields- record-name))

(defmacro get-fields (record-name)
  `(,(make-fields-macro-name `,(cadr record-name))))
