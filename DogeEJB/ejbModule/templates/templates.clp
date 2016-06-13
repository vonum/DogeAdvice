(deftemplate diagnosis
	(slot name (type STRING))
    (slot user (type STRING))
)

(deftemplate symptom
    (declare (backchain-reactive TRUE))
	(slot name (type STRING))
    (slot value (allowed-values TRUE FALSE))
    (slot user (type STRING))    
)

(deftemplate question
    (slot for-symptom (type STRING))
    (slot text (type STRING))
)

