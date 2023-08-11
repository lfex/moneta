(defrecord employee
  id
  name
  department-id
  projects)

(defrecord department
  id
  name)

(defrecord project
  name
  number)

(defrecord manager
  employee-id
  department-id)

(defrecord in-department
  employee-id
  department-id)

(defrecord in-project
  employee-id
  project-name)

(defun --loaded-example-tables-- ()
  "This is just a dummy function for display purposes when including from the
  REPL (the last function loaded has its name printed in stdout).
  This function needs to be the last one in this include."
  'ok)
