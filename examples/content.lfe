(defmodule content
  (export all))

(include-lib "mnesiatut/include/tables.lfe")

(defun insert-departments
  "A utility function for populating the department table."
  (('())
   'ok)
  (((cons (list id name) tail))
   (let ((department (make-department id id name name)))
     (mnesia:transaction (lambda () (mnesia:write department)))
     (insert-departments tail))))

(defun insert-projects
  "A utility function for populating the project table."
  (('())
   'ok)
  (((cons (list name number) tail))
   (let ((project (make-project name name number number)))
     (mnesia:transaction (lambda () (mnesia:write project)))
     (insert-projects tail))))

(defun insert-employee (employee department-id project-names)
  "A utility function for populating the employee table and updating all the
  associated relationships."
  (mnesia:transaction
    (lambda ()
      (mnesia:write employee)
      (insert-department-relation (employee-id employee) department-id)
      (insert-project-relations (employee-id employee) project-names))))

(defun insert-department-relation (employee-id department-id)
  "A function that is used when establishing the relationship between an
  employee and a department."
  (let ((in-department (make-in-department
                              employee-id employee-id
                              department-id department-id)))
    (mnesia:write in-department)))

(defun insert-project-relations
  "A function that is used when establishing the relationships between an
  employee and any number of projects."
  ((_ '())
    'ok)
  ((employee-id (cons project-name tail))
    (let ((in-project (make-in-project
                        employee-id employee-id
                        project-name project-name)))
      (mnesia:write in-project)
      (insert-project-relations employee-id tail))))

(defun insert-employees
  "Batch 'em up."
  (('())
    'ok)
  (((cons (list id nm sal gen ph rm dep projs) tail))
    (let ((employee (make-employee
                      id id
                      name nm
                      salary sal
                      gender gen
                      phone ph
                      room-number rm)))
      (insert-employee employee dep projs)
      (insert-employees tail))))

(defun insert-manager (employee-id department-id)
  (mnesia:transaction
    (lambda ()
      (mnesia:write
        (make-manager employee-id employee-id
                      department-id department-id)))))
