# Content

We've created tables and we know how to inspect their metadata; now let's give them *data*. From the previous chapter, you should have the example records available to after including them:

``` cl
lfe> (include-file "examples/tables.lfe")
```

## Department Data

With those present (and the macros automatically created for us when those records were included), let's create a list of departments:

``` cl
(set depts
  (list
    (make-department id 'B/SF name "Open Telecom Platform")
    (make-department id 'B/SFP name "OTP - Product Development")
    (make-department id 'B/SFR name "Computer Science Laboratory")))
```

And then we can insert this data with the following:

``` cl
lfe> (mnta-qry:insert depts)
ok
```

To see everything we just inserted, we can use a moneta convenience function:


``` cl
lfe> (set `#(atomic ,results) (mnta-qry:select-all 'department))
```

These results are department records, so we can iterate over them and use their record macros. For example:

``` cl
(lists:map (lambda (r) (department-name r)) results) 
```

which gives:

``` cl
("Open Telecom Platform"
 "OTP - Product Development"
 "Computer Science Laboratory")
```

## Project Data

We can repeat this process for the following projects:

``` cl
(set projs
  (list
    (make-project name 'erlang number 1)
    (make-project name 'otp number 2)
    (make-project name 'beam number 3)
    (make-project name 'mnesia number 5)
    (make-project name 'wolf number 6)
    (make-project name 'documentation number 7)
    (make-project name 'www number 8)))
```

``` cl
lfe> (mnta-qry:insert projs)
ok
lfe> (mnta-qry:select-all 'project)
#(atomic
  (#(project wolf 6)
   #(project erlang 1)
   #(project beam 3)
   #(project otp 2)
   #(project documentation 7)
   #(project www 8)
   #(project mnesia 5)))
```

## Relationships

Next we'll explore the relational aspect of our data. First, let's create some employee records:

``` cl
(set empls
  (list
    (make-employee id 1 name "Johnson Torbjorn" department-id 'B/SF
                   projects '(otp))
    (make-employee id 2 name "Carlsson Tuula" department-id 'B/SF
                   projects '(otp))
    (make-employee id 3 name "Dacker Bjarne" department-id 'B/SFR
                   projects '(otp))
    (make-employee id 4 name "Nilsson Hans" department-id 'B/SFR
                   projects '(mnesia otp))
    (make-employee id 5 name "Tornkvist Torbjorn" department-id 'B/SFR
                   projects '(otp wolf))
    (make-employee id 6 name "Fedoriw Anna" department-id 'B/SFR
                   projects '(documentation otp))
    (make-employee id 7 name "Mattsson Hakan" department-id 'B/SFR
                   projects '(mnesia otp))))
```

Since we have relationships with other tables, we'll need to augment the employee insert operation. We can do that by providing a custom function that will be called inside the transaction:

``` cl
(defun add-relations
  (((match-employee id id department-id dept-id projects projs))
   (mnesia:write (make-in-department employee-id id department-id dept-id))
   (lists:map
     (lambda (p)
       (mnesia:write (make-in-project employee-id id project-name p)))
     projs)))

(defun insert-employee
  (((= (match-employee id id department-id dept-id projects projs) record))
   (mnesia:transaction
    (lambda ()
      (mnesia:write record)
      (mnesia:write (make-in-department employee-id id department-id dept-id))
      (lists:map
       (lambda (p)
         (mnesia:write (make-in-project employee-id id project-name p)))
       projs)))))
```

We can then insert the employee data and create all the relations with this:

``` cl
lfe> (mnta-qry:insert empls #'add-relations/1)
```

And then use what we did before to check the inserts:

``` cl
lfe> (mnta-qry:select-all 'employee)
lfe> (mnta-qry:select-all 'in-department)
lfe> (mnta-qry:select-all 'in-project)
```