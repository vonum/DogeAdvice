(batch "templates/templates.clp")
(import socket.client.ClientMessenger)

(defrule ask-question
   ?var <- (need-symptom (name ?name) (user ?u))
   (question (for-symptom ?name) (text ?text))
   ;(not(diagnosis (user ?u)))
    =>
   ;(store ?u ?var)
   (call ?bridge sendMessage (str-cat "question:" ?u ":symptom:" ?name ":" ?text))
   ;(printout t ?text crlf)
 	;(assert(symptom(name ?name) (value (read t)) (user ?u)))   
)

(defrule ask-local
    (need-localization (name ?name) (user ?u))
    (question (for-symptom ?name) (text ?text))
    ;(not(diagnosis))
    =>
    (call ?bridge sendMessage (str-cat "question:" ?u ":localization:" ?name ":" ?text))
    
    
)