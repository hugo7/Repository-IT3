#Übungsblatt 4, Aufgabe 4
#Dennis Hoffmann

#Funktionsdefintion
def summe(x, y)
	ergebnis = x + y
	return ergebnis
end

#Zuweisung der Programmargumente
a,b=ARGV

#Ausgabe
puts "Bitte zwei Zahlen eingeben"

#Benutzereingabe
a=gets.to_i
b=gets.to_i


#Aufruf der Funktion Summe
wert=summe(a, b)

#Bildschirmausgabe
puts "#{a}+#{b}=#{wert}"
