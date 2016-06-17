(deftemplate diagnosis
	(slot name (type STRING))
)

(deftemplate symptom
    (declare (backchain-reactive TRUE))
	(slot name (type STRING))
    (slot value (allowed-values TRUE FALSE))    
)

(deftemplate question
    (slot for-symptom (type STRING))
    (slot text (type STRING))
)

(deftemplate localization
    (declare (backchain-reactive TRUE))
	(slot name (type String))    
)

(defrule ask-question
   (need-symptom (name ?name))
   (question (for-symptom ?name) (text ?text))
   (not(diagnosis))
    =>
    (printout t ?text crlf)
 	(assert(symptom(name ?name) (value (read t)))) 
    ;(facts)   
)

(defrule ask-local
	(need-localization (name ?name))
    (question (for-symptom ?name) (text ?text))
    (not(diagnosis))
    =>
    (printout t ?text crlf)
    (assert(localization (name ?name)))
)

(deffacts questions
    (question (for-symptom gornji-trakt) (text "Da li je gornji trakt?"))
    (question (for-symptom donji-trakt) (text "Da li je donji trakt?"))
	(question (for-symptom grkljan-nos) (text "Da li se promene uocavaju od grkljana do nosa?"))
    (question (for-symptom grkljan) (text "Da li se promene uocavaju na grkljanu?"))
    (question (for-symptom dusnik) (text "Da li se promene uocavaju na dusniku?"))
    (question (for-symptom upala-sluzokoze-nos) (text "Da li se uocava upala sluzokoze u nosu?"))
    (question (for-symptom strano-telo-nos) (text "Da li se uocava strano telo u nosu?"))
    (question (for-symptom tumor-nos) (text "Da li se uocava izrastaj u nosnoj supljini?"))
    (question (for-symptom crvenilo-krajnici) (text "Da li se uocavam crvenilo u predelu krajnika?"))
    (question (for-symptom oteceni-krajnici) (text "Da li su krajnici oteceni?"))
    (question (for-symptom bol-krajnici) (text "Da li pas oseca bol pri dodiru krajnika?"))
    
)

(defrule rhinitis
	(localization (name gornji-trakt))
    (localization (name grkljan-nos))    
    (symptom (name upala-sluzokoze-nos) (value TRUE))
    =>
    (assert(diagnosis (name rhinitis)))
)

(defrule strano-telo-nos
    (localization (name gornji-trakt))
    (localization (name grkljan-nos))    
    (symptom (name strano-telo-nos) (value TRUE))
    =>
    (assert(diagnosis (name strano-telo-nos)))
)

(defrule tumor-nos
    (localization (name gornji-trakt))
    (localization (name grkljan-nos))    
    (symptom (name tumor-nos) (value TRUE))
    =>
    (assert(diagnosis (name tumor-nos)))
)

(defrule upala-krajnika
    (localization (name gornji-trakt))
    (localization (name grkljan-nos))    
    (symptom (name crvenilo-krajnici) (value TRUE))
    (symptom (name oteceni-krajnici) (value TRUE))
    (symptom (name bol-krajnici) (value TRUE))
    =>
    (assert(diagnosis (name upala-krajnika)))
)

(reset)
(facts)
(run)
(facts)