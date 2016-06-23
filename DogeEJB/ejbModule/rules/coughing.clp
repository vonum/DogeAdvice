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
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Foreign body in nose"))
)

(defrule tumor-nos
    (symptom (name coughing) (user ?u))
    (localization (name gornji-trakt) (user ?u))
    (localization (name grkljan-nos) (user ?u))    
    (symptom (name tumor-nos) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name tumor-nos) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Nose tumor"))
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