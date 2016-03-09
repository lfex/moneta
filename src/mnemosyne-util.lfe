(defmodule mnemosyne-util
  (export all))

(defun get-version ()
  (lutil:get-app-version 'mnemosyne))

(defun get-versions ()
  (++ (lutil:get-versions)
      `(#(mnemosyne ,(get-version)))))
