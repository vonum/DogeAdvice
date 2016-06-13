(deftemplate user
	(declare (backchain-reactive TRUE))
    (multislot symptom)    
    (multislot infection)
    (slot id)
)

(deftemplate diagnosis
	(slot name)    
    (slot user)
)

(deftemplate question
	(slot name)
    (slot string)    
)

(defrule askquestion
   (need-user (id ?id) (symptom $? ?value $?) (infection $?) )
   ;(question (name ?name) (string ?string))
   (not (diagnosis (user ?id)))
   =>
   ;(retract ?tmp)
   (printout t "works " ?value crlf)
   ;(assert (symptom (name ?name) (value (read)))))
   /*(bind ?resp (read t))
    (if (= ?rest "true")
     	then 
        (
          (bind ?tmp (fact-slot-value user id ?id))
          (modify ?tmp (symptom (insert$ ?tmp.symptom 4 jebac)))
        )    
        
    )    */   
)

(defrule random
    (user (symptom $? rand $?) (id ?id) )
    =>
    (assert (diagnosis (name rand) (user ?id)))
)



(reset)

(bind ?tmp (assert (user (id 1) (symptom sim1 sim2 rand) (infection))))

(facts)

;(modify ?tmp (symptom (insert$ ?tmp.symptom 3 sim3)))

(run)
(facts)