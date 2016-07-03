(batch "templates/templates.clp")
(import socket.client.ClientMessenger)

(defrule rhinitis
    (symptom (name coughing) (user ?u))
	(localization (name gornji-trakt) (user ?u))
    (localization (name grkljan-nos) (user ?u))    
    (symptom (name upala-sluzokoze-nos) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name rhinitis) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Rhinitis"))
)

(defrule strano-telo-nos
    (symptom (name coughing) (user ?u))
    (localization (name gornji-trakt) (user ?u))
    (localization (name grkljan-nos) (user ?u))    
    (symptom (name strano-telo-nos) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name strano-telo-nos) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Strano telo u nosu"))
)

(defrule tumor-nos
    (symptom (name coughing) (user ?u))
    (localization (name gornji-trakt) (user ?u))
    (localization (name grkljan-nos) (user ?u))    
    (symptom (name tumor-nos) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name tumor-nos) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Tumor u nosu"))
)

(defrule upala-krajnika
    (symptom (name coughing) (user ?u))
    (localization (name gornji-trakt) (user ?u))
    (localization (name grkljan-nos) (user ?u))    
    (symptom (name crvenilo-krajnici) (value TRUE) (user ?u))
    (symptom (name oteceni-krajnici) (value TRUE) (user ?u))
    (symptom (name bol-krajnici) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name upala-krajnika) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Upala krajnika"))
)

(defrule strano-telo-grkljan
	(symptom (name coughing) (user ?u))    
    (localization (name gornji-trakt) (user ?u))
    (localization (name grkljan) (user ?u))
    (symptom (name strano-telo-grkljan) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name strano-telo-grkljan) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Strano telo na grkljanu"))
)

(defrule upala-grkljan
	(symptom (name coughing) (user ?u))    
    (localization (name gornji-trakt) (user ?u))
    (localization (name grkljan) (user ?u))
    (symptom (name crvenilo-grkljan) (value TRUE) (user ?u))
    (symptom (name otecen-grkljan) (value TRUE) (user ?u))
    (symptom (name bol-grkljan) (value TRUE) (user ?u))	
    =>
    (assert(diagnosis (name upala-grkljan) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Upala grkljana"))    
)

(defrule tumor-grkljan
	(symptom (name coughing) (user ?u))    
    (localization (name gornji-trakt) (user ?u))
    (localization (name grkljan) (user ?u))
    (symptom (name tumor-grkljan) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name tumor-grkljan) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Tumor na grkljanu"))    
)

(defrule povreda-grkljan
 	(symptom (name coughing) (user ?u))    
    (localization (name gornji-trakt) (user ?u))
    (localization (name grkljan) (user ?u))
    (symptom (name povreda-grkljan) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name poreda-grkljan) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Povreda na grkljanu"))        
)

(defrule upala-dusnik
	(symptom (name coughing) (user ?u))    
    (localization (name gornji-trakt) (user ?u))
    (localization (name dusnik) (user ?u))
    (symptom (name crvenilo-dusnik) (value TRUE) (user ?u))
    (symptom (name otecen-dusnik) (value TRUE) (user ?u))
    (symptom (name bol-dusnik) (value TRUE) (user ?u))	
    =>
    (assert(diagnosis (name upala-dusnik) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Upala dusnika"))     
)

(defrule infekcija-dusnik
	(diagnosis (name upala-dusnik) (user ?u))    
    (symptom (name bakterija-dusnik) (value TRUE) (user ?u))
	=>
    (assert(diagnosis (name infekcija-dusnik) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Infekcija dusnika"))          
)

(defrule strano-telo-dusnik
	(symptom (name coughing) (user ?u))    
    (localization (name gornji-trakt) (user ?u))
    (localization (name dusnik) (user ?u))
    (symptom (name strano-telo-dusnik) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name strano-telo-dusnik) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Strano telo u dusniku"))    
)

(defrule tumor-dusnik
	(symptom (name coughing) (user ?u))    
    (localization (name gornji-trakt) (user ?u))
    (localization (name dusnik) (user ?u))
    (symptom (name tumor-dusnik) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name tumor-dusnik) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Tumor u dusniku"))    
)