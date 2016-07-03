(batch "templates/templates.clp")
(import socket.client.ClientMessenger)

(defrule ask-question
   (need-symptom (name ?name) (user ?u))
   (question (for-symptom ?name) (text ?text))
    =>
   (call ?bridge sendMessage (str-cat "question:" ?u ":symptom:" ?name ":" ?text))  
)

(defrule ask-local
    (need-localization (name ?name) (user ?u))
    (question (for-symptom ?name) (text ?text))
    =>
    (call ?bridge sendMessage (str-cat "question:" ?u ":localization:" ?name ":" ?text))
)