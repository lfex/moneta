(defmodule mnt-util
  (export all))

(defun get-version ()
  (lutil:get-app-version 'moneta))

(defun get-versions ()
  (++ (lutil:get-versions)
      `(#(moneta ,(get-version)))))
