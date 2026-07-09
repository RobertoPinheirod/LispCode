;;; Code for the form named :form1 of class dialog.
;;; The inspector may add event-handler starter code here,
;;; and you may add other code for this form as well.
;;; The code for recreating the window is auto-generated into 
;;; the *.bil file having the same name as this *.cl file.
(in-package :common-graphics-user)

(defun form1-button1-on-click (dialog widget)
  (declare (ignorable dialog widget))
  (let* ((campo-sigma   (find-component :editable-text-1 dialog))
         (campo-n       (find-component :editable-text-2 dialog))
         (campo-saida   (find-component :editable-text-3 dialog))
         (sigma-str     (value campo-sigma))
         (n-str         (value campo-n)))
    (handler-case
        (let* ((sigma (parse-number-seguro sigma-str))
               (n     (or (parse-number-seguro n-str) 1.0d0)))
          (cond
            ((null sigma)
             (setf (value campo-saida) "Erro: Sigma invalido"))
            ((<= sigma 0)
             (setf (value campo-saida) "Erro: Sigma deve ser > 0"))
            (t
             (let ((lambda-livre (/ 1.0d0 sigma)))
               (setf (value campo-saida)
                     (format nil "lambda = ~,4F cm  |  n*lambda = ~,4F cm"
                             lambda-livre (* n lambda-livre)))))))
      (error (e)
        (setf (value campo-saida)
              (format nil "Erro inesperado: ~A" e)))))
  t)

(defun parse-number-seguro (str)
  "Tenta converter string para double-float; retorna nil se falhar."
  (when (and str (> (length (string-trim " " str)) 0))
    (ignore-errors
      (let ((*read-default-float-format* 'double-float))
        (coerce (read-from-string (string-trim " " str)) 'double-float)))))