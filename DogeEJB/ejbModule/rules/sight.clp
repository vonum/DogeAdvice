(batch "templates/templates.clp")
(import socket.client.ClientMessenger)

(defrule problem-socivo
    (symptom (name sight) (value TRUE) (user ?u))
	(localization (name socivo) (user ?u))    
    =>
    (assert(symptom(name problem-socivo) (value TRUE) (user ?u)))
)

(defrule problem-mreznjaca
    (symptom (name sight) (value TRUE) (user ?u))
	(localization (name mreznjaca) (user ?u))    
    =>
    (assert(symptom(name problem-mreznjaca) (value TRUE) (user ?u)))
)

(defrule problem-nerv
    (symptom (name sight) (value TRUE) (user ?u))
	(localization (name nerv) (user ?u))    
    =>
    (assert(symptom(name problem-nerv) (value TRUE) (user ?u)))
)



(defrule katarakta
    (symptom (name problem-socivo) (value TRUE) (user ?u))
    (symptom (name zamucenje-socivo) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name katarakta) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Katarakta sociva"))
)

(defrule aphakia
    (symptom (name problem-socivo) (value TRUE) (user ?u))
    (symptom (name prisutno-socivo) (value FALSE) (user ?u))
    =>
    (assert(diagnosis (name katarakta) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Aphakia, nedostatak sociva"))
)

(defrule mikrophakia
    (symptom (name problem-socivo) (value TRUE) (user ?u))
    (symptom (name premalo-socivo) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name katarakta) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Mikrophakia, premalo sociva"))
)

(defrule pomereno-socivo
    (symptom (name problem-socivo) (value TRUE) (user ?u))
    (symptom (name centrirano-socivo) (value FALSE) (user ?u))
    =>
    (assert(diagnosis (name katarakta) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Pomereno socivo od centra"))
)




(defrule odvajanje-mreznjace
    (symptom (name problem-mreznjaca) (value TRUE) (user ?u))
    (symptom (name odvajanje-mreznjaca) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name odvajanje-mreznjace) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Odvajanje mreznjace"))
)

(defrule progresivno-gubljenje-vida
    (symptom (name problem-mreznjaca) (value TRUE) (user ?u))
    (symptom (name vid-slabi-vremenom) (value TRUE) (user ?u))
    (symptom (name losije-vidi-nocu) (value TRUE) (user ?u))
    (symptom (name slabi-pupilarni-refleks) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name odvajanje-mreznjace) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Progresivno gubljenje vida"))
)




(defrule zapaljenje-nerv
    (symptom (name problem-nerv) (value TRUE) (user ?u))
    (symptom (name zapaljenje-nerv) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name zapaljenje-nerv) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Zapaljenje optickog nerva"))
)

(defrule tumor-nerv
    (symptom (name problem-nerv) (value TRUE) (user ?u))
    (symptom (name izrastaj-nerv) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name tumor-nerv) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Tumor na optickom nervu"))
)

(defrule patoloska-povreda-nerv
    (symptom (name problem-nerv) (value TRUE) (user ?u))
    (symptom (name pat-povreda-nerv) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name tumor-nerv) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Patoloska povreda optickog nerva"))
)

(defrule hipoplazija-nerv
    (symptom (name problem-nerv) (value TRUE) (user ?u))
    (symptom (name tanak-nerv) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name tumor-nerv) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Hipoplazija optickog nerva"))
)

