(batch "templates/templates.clp")
(import socket.client.ClientMessenger)

(defrule fear-induced
    (symptom (name aggression) (value TRUE) (user ?u))
	(symptom (name approached) (value TRUE) (user ?u))
    (or (symptom (name head-down) (value TRUE) (user ?u))
        (symptom (name tail-tucked) (value TRUE) (user ?u))
        (symptom (name eyes-wide-open) (value TRUE) (user ?u))
    )    
    =>
    (assert(diagnosis (name fear-induced-aggression) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Fear induced aggression"))   
)

(defrule dominance-related
    (symptom (name aggression) (value TRUE) (user ?u))
	(symptom (name resents-reaching-towards) (value TRUE) (user ?u))
    (symptom (name approaching-food) (value TRUE) (user ?u))
        (or (symptom (name head-up) (value TRUE) (user ?u))
    	(symptom (name tail-up) (value TRUE) (user ?u))    
    )     
    =>
    (assert (diagnosis (name dominance-related-aggression) (user ?u)))  
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Dominance related aggression"))
)

(defrule territorial
    (symptom (name aggression) (value TRUE) (user ?u))
    (symptom (name barks) (value TRUE) (user ?u))
    (or (symptom (name towards-strangers) (value TRUE) (user ?u))
    	(symptom (name towards-dogs) (value TRUE) (user ?u))    
    ) 
    (or (symptom (name rushes-forward) (value TRUE) (user ?u))
        (symptom (name bares-teeth) (value TRUE) (user ?u)) 
    )
	=>
    (assert (diagnosis (name territorial-aggression)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Territorial aggression")) 
)

(defrule parental
    (symptom (name aggression) (value TRUE) (user ?u))
	(symptom (name has-puppies) (value TRUE) (user ?u))
    (symptom (name puppies-young) (value TRUE) (user ?u))
    (symptom (name aggressive-when-puppies-approached) (value TRUE) (user ?u))    
    =>
    (assert(diagnosis (name parental-aggression)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Parental aggression"))
)

(defrule irritable
    (symptom (name aggression) (value TRUE) (user ?u))
	(symptom (name aggressive-when-associated-with-pain) (value TRUE) (user ?u)) 
    =>
    (assert(diagnosis (name irritable-aggression)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Irritable aggression"))
)

(defrule protective
    (symptom (name aggression) (value TRUE) (user ?u))
    (symptom (name owner-present) (value TRUE) (user ?u)) 
    (symptom (name owner-approached) (value TRUE) (user ?u)) 
    (symptom (name towards-strangers) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name protective-aggression)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Protective aggression"))  
)