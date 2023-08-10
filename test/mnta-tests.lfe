(defmodule mnta-tests
  (behaviour ltest-system)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(defrecord test-table
  id
  name
  data)

(deftest create-schema
  (is-equal 'ok (mnta:create-schema #(start true))))

; (deftest create-table
;   (is-equal #(atomic ok) (mnta:create-table 'test-table)))
