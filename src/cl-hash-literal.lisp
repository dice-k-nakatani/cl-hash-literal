(defpackage cl-hash-literal
  (:use :cl)
  (:export :with-hash-literal-printer)
  )
(in-package :cl-hash-literal)

(defun num-to-testsym (numarg)
  (case numarg
    (0 'eq)
    (1 'eql)
    (2 'equal)
    (3 'equalp)
    (t 'equal)))

(defun testsym-to-num (sym)
  (case sym
    ('eq 0)
    ('eql 1)
    ('equal 2)
    ('equalp 3)
    (t 3)))

(defun hash-table-reader (stream sub-char numarg)
  (declare (ignore sub-char))
  (read-char stream)
  (let ((k (gensym "K"))
        (v (gensym "V"))
        (obj (gensym "OBJ")))
    `(let ((,obj (make-hash-table :test ',(num-to-testsym numarg))))
       (setf
        ,@(loop for (k v . _) on (read-delimited-list #\) stream t) by #'cddr
                collect `(gethash ,k ,obj)
                collect v))
       ,obj)))

(defmacro with-hash-literal-printer (&body body)
  "Temporarily overwrite print-object function."
  `(let ((org-method (find-method #'print-object '() (mapcar #'find-class '(hash-table t)))))
     (unwind-protect
          (progn
            (defmethod print-object ((obj hash-table) stream)
              (let ((numarg (testsym-to-num (hash-table-test obj))))
                (format stream "#~dh(" numarg)
                (maphash (lambda (k v)
                           (format stream "~s ~s " k v))
                         obj)
                (format stream ")")))
            ,@body
            )

       (add-method #'print-object org-method))))

(in-package :cl-user)
(cl-syntax:define-package-syntax :cl-hash-literal
  (:merge :standard)
  (:dispatch-macro-char #\# #\h #'cl-hash-literal::hash-table-reader))


;;;;;
;;(defun hash-table-reader (stream sub-char numarg)
;;  (declare (ignore sub-char))
;;  (read-char stream)
;;  (with-gensyms (k v)
;;    `(multiple-value-bind (,k ,v) (chunk 2 2 (scan (list ,@(read-delimited-list #\) stream t))))
;;       (collect-hash ,k ,v 
;;                     :test ',(case numarg (0 'eq) (1 'eql) (2 'equal) (3 'equalp) (t 'equal))))))


