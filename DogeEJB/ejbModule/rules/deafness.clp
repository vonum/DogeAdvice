(batch "templates/templates.clp")
(import socket.client.ClientMessenger)

(defrule problem-kanala
    (symptom (name deafness) (value TRUE) (user ?u))
	(localization (name usni-kanal) (user ?u))    
    =>
    (assert(symptom(name problem-kanala) (value TRUE) (user ?u)))
)

(defrule stenoza-kanala
    (symptom (name problem-kanala) (value TRUE) (user ?u))
    (symptom (name suzenje-kanala) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name stenoza-kanala) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Stenoza usnog kanala"))
)

(defrule tumor-kanala
    (symptom (name problem-kanala) (value TRUE) (user ?u))
    (symptom (name tumor-kanala) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name tumor-kanala) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Tumor u usnom kanalu"))
)

(defrule probijena-bubna-opna
    (symptom (name problem-kanala) (value TRUE) (user ?u))
    (symptom (name krv-usni-kanal) (value TRUE) (user ?u))
    (symptom (name rupture-bubne-opne) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name stenoza-kanala) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Probijena bubna opna"))
)

(defrule upala-srednjeg-uha
    (symptom (name problem-kanala) (value TRUE) (user ?u))
    (symptom (name povecana-kolicina-krvi-uho) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name stenoza-kanala) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Upala srednjeg uha"))
)

(defrule gluvilo-lekovi
    (symptom (name deafness) (value TRUE) (user ?u))
    (symptom (name uzimanje-antibiotika) (value TRUE) (user ?u))
    (symptom (name antibiotici)  (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name stenoza-kanala) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Gluvilo uzrokovano lekovima"))     
)

(defrule degenerativne-promene
    (symptom (name deafness) (value TRUE) (user ?u))
    (symptom (name starost) (value TRUE) (user ?u))
    (symptom (name promene-sluha-tokom-vremena) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name degenerativne-promene) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Gluvilo uzrokovano starenjem"))     
)

(defrule hiperplazija-puz
    (symptom (name deafness) (value TRUE) (user ?u))
    ;(symptom (name postojanje-puz) (value TRUE) (user ?u))
    (symptom (name manjak-celija-puz) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name hiperplazija-puz) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Hiperplazija puza"))     
)

(defrule aplazija-puz
    (symptom (name deafness) (value TRUE) (user ?u))
    (symptom (name postojanje-puz) (value FALSE) (user ?u))
    =>
    (assert(diagnosis (name hiperplazija-puz) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Aplazija puza"))     
)

(defrule tumor-nerv
    (symptom (name deafness) (value TRUE) (user ?u))
    (symptom (name tumor-nerv) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name tumor-nerv) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Tumor na nervu ili okolnom tkivu"))     
)

(defrule povreda-nerv
    (symptom (name deafness) (value TRUE) (user ?u))
    (symptom (name povreda-nerv) (value TRUE) (user ?u))
    =>
    (assert(diagnosis (name povreda-nerv) (user ?u)))
    (call ?bridge sendMessage (str-cat "diagnosis:" ?u ":" "Povreda nerva"))     
)


