## Assessment-Aufgabe für Bewerbung beim Jö-Bonusclub

Dieses Repository beinhaltet ein R-Projekt, in dem ich ein von Jö bereitgestelltes Datenset zu den Umsätzen von Filialen (vermutlich der REWE-Gruppe) in ganz Österreich analysiere. Die Analyse wird zu 100% in R durchgeführt, jedoch ist der Output des R-Makdown-Files ein HTML-Dokument, das einen sehr grossen Teil des Repositorys einnimmt. 
Die PRojekt-Struktur ist wie folgt:

* 00_master.R ist das Masterfile, das alle anderen Files durchlaufen lässt, d.h. im Grunde muss man nur aktiv dieses eine Skript laufen lassen um die ganze Analyse (inklusive Output als HTML-Dokument) zu generieren. Hier werden auch alle Packages geladen, die später gebraucht werden.
* 01_assess.R liest die Daten in Rohform ein, sieht sie durch und entfernt NAs (optional). Ausserdem werden hier neue Variablen generiert die in späteren Schritten gebraucht werden. Am Ende speichert es einen neuen Datensatz, der für die eigentliche Analyse bereit ist.
* 02_descriptives.R leistet den deskriptiven Teil der Analyse, inkl. der Generierung von Plots. Alle hier generierten Elemente werden in den Ordnern "data" und "figures" gespeichert.
* 03_regressions.R untersucht weitere Zusammenhänge mittels linearen Regressionen. Die Ergebnisse werden im "data"-Ordner gespeichert.
* 04_final_doc.Rmd greift nochmal auf die vorhin generierten und gespeicherten Elemente zu und bereitet sie in einem schönen HTML-Dokument auf. Alles hier ist automatisiert, i.e. sollten sich die Daten am Anfang ändern, und in Folge die Elemente aus den Skripten 01 und 02, wird auch der Output im HTML-Dokument geupdatet.
* 05_gmaiR.R ist noch in der Experimentierphase. Es sollte in der Lage sein, sich über eine API mit meinem Gmail-Account zu verbinden und eine Email mit dem fertigen Output an mich selber (oder eine beliebige Mail-Adresse) zu senden.

 
