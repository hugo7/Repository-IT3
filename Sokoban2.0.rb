Shoes.app :title => "SOKOBAN 2.0", :width => 600, :height => 400, :resizable => false do

#-- KONSTANTEN --
RAND = 0	
	
#Breite und Höhe der Rechtecke 
BREITE = 50 
HOEHE= 50
		

#ARRAY-MATRIX hinter dem Spielfeld
# 0 = leeres Feld (begehbar)
# 1 = Mauer (statisch)
# 2 = Sonnenblume 
# 3 = Giesskanne
# 5= Ecke

@feld = [[1,1,1,1,1,1,1,1,1,1,1,1],
		[1,5,0,0,0,0,0,0,0,0,5,1],
		[1,0,0,1,1,1,0,0,0,0,0,1],
		[1,0,0,0,5,1,0,0,1,0,5,1],
		[1,0,0,0,0,1,0,0,1,1,1,1],
		[1,0,1,0,0,0,0,0,0,0,0,1],
		[1,5,0,0,0,0,0,5,1,0,0,1],
		[1,1,1,1,1,1,1,1,1,1,1,1]]

anzahl_zeilen = 8
anzahl_spalten = 12	


# ARRAY anzeigen (zunaechst Rechtecke und Gaertner)

# Rechtecke Position
x_pos = 0
y_pos = 0


anzahl_zeilen.times do |y|
	anzahl_spalten.times do |x|
			
		if @feld[y][x] == 0 or @feld[y][x] == 3 or @feld[y][x] == 5 or @feld[y][x] == 2 then
			fill gainsboro  
			rect(x_pos + x * 50, y_pos + y * 50, BREITE, HOEHE)
	 
		elsif @feld[y][x] == 1 then
			image "mauerspiel.jpg", :top => y*50, :left => x*50
	   
		end #if
	end #innere Schleife
end #äußere Schleife
					

# ----GAERTNER----

# Position Gaertner
@position_x = 1
@position_y = 1

@gaertner = image "gaertner.jpg", :top => @position_y * 50, :left => @position_x * 50
 
# --- Giesskanne -- 
 @pos_g_x = 2
 @pos_g_y = 4
 @feld[@pos_g_y][@pos_g_x] = 3
 @giesskanne = image "giesskanne.jpg", :top => @pos_g_y * 50, :left => @pos_g_x * 50
  
 def giesskanne_neu_setzen ()
	#@pos_g_x = @pos_g_x 
	#@pos_g_y = @pos_g_y
	@giesskanne = image "giesskanne.jpg", :top => @pos_g_y * 50, :left => @pos_g_x * 50
 end

# -- Sonnenblume -- 

	@pos_s_x = 10
	@pos_s_y = 3
	@feld[@pos_s_y][@pos_s_x] = 2
	@sonnenblume = image "sonnenblume1.jpg", :top => @pos_s_y * 50, :left => @pos_s_x * 50
 
 
# ---- LAUFEN ---
# Der Gaertner soll durch Druecken der Pfeiltasten (right, left, up, down) entsprechend bewegt werden koennen

def bewegen(key)
   
   # Bewegung nach Rechts 
   if key == :right then 
		
		if @feld[@position_y][@position_x +1] == 0 or 			# FALL: Gärtner fährt auf leeres Feld
		   @feld[@position_y][@position_x +1] == 5 then 		# FALL: Gärtner fährt gegen Ecke
				@position_x = @position_x + 1
			
		elsif @feld[@position_y][@position_x +1] == 1 then   # FALL: Gartner fährt gegen Wand
				@position_x = @position_x
				
		elsif @feld[@position_y][@position_x +1] == 3 then	# FALL: Gärtner fährt gegen Gießkanne		
		
			if	@feld[@pos_g_y][@pos_g_x + 1] == 0 then 	# FALL: Ist Feld neben der Gießkanne frei??
					@position_x = @position_x + 1				# Bewege den Gärtner			
		
					@feld[@pos_g_y][@pos_g_x] = 0 				# Alter Wert im Array wird auf 0 gesetzt -> leeres Feld 		 
					@pos_g_x = @pos_g_x +1 						# X-Position wird verändern -> bewegt sich ein Feld (im Array) nach rechts
					@giesskanne.remove							# Gießkanne wird gelöscht
					giesskanne_neu_setzen( ) 					# Gießkanne wird neu gesetzt
					@feld[@pos_g_y][@pos_g_x] = 3 				# Neuer Wert wird im Array an neuer Position gesetzt
					
			elsif @feld[@pos_g_y][@pos_g_x + 1] == 5 then	
					@position_x = @position_x + 1				
		
					@feld[@pos_g_y][@pos_g_x] = 0 				 
					@pos_g_x = @pos_g_x +1 						
					@giesskanne.remove							
					giesskanne_neu_setzen( ) 					
					@feld[@pos_g_y][@pos_g_x] = 3 
					alert "GAME OVER!"
					clear
      				button "Spiel neu starten"
      				button "Spiel beenden"
			
			elsif @feld[@pos_g_y][@pos_g_x + 1] == 1 then	
					@position_x = @position_x
					@pos_g_y = @pos_g_y
					
			elsif @feld[@pos_g_y][@pos_g_x + 1] == 2 then	
					@sonnenblume.remove
					@feld[@pos_s_y][@pos_s_x] = 3
					
					@position_x = @position_x + 1				
					
					@feld[@pos_g_y][@pos_g_x] = 0 				 
					@pos_g_x = @pos_g_x +1 	
					@giesskanne.remove							
					giesskanne_neu_setzen( ) 					
					@feld[@pos_g_y][@pos_g_x] = 3 
					alert "Du hast gewonnen!"
					clear
      				button "Spiel neu starten"
      				button "Spiel beenden"
			end
			
			
		end # Ende der if feld = 0 Verzweigung
		
		
	 # Bewegung nach Links
	  elsif key == :left then
		  
		if @feld[@position_y][@position_x -1] == 0 or
			@feld[@position_y][@position_x -1] == 5 then
				@position_x = @position_x - 1
		
		elsif @feld[@position_y][@position_x -1] == 1 then 
					@position_x = @position_x
			
		elsif @feld[@position_y][@position_x -1] == 3 then 
					
			if	@feld[@pos_g_y][@pos_g_x - 1] == 0  then 
					@position_x = @position_x - 1
				
					@feld[@pos_g_y][@pos_g_x] = 0 				 
					@pos_g_x = @pos_g_x -1 						
					@giesskanne.remove							
					giesskanne_neu_setzen( ) 					
					@feld[@pos_g_y][@pos_g_x] = 3 	
				
			elsif @feld[@pos_g_y][@pos_g_x - 1] == 5 then 
					@position_x = @position_x - 1
					
					@feld[@pos_g_y][@pos_g_x] = 0 				 
					@pos_g_x = @pos_g_x -1 						
					@giesskanne.remove							
					giesskanne_neu_setzen( ) 					
					@feld[@pos_g_y][@pos_g_x] = 3 
					alert "Game over!"
					clear
      				button "Spiel neu starten"
      				button "Spiel beenden"							
			
			elsif @feld[@pos_g_y][@pos_g_x - 1] == 1 then	
					@position_x = @position_x
					@pos_g_y = @pos_g_y
					
			elsif @feld[@pos_g_y][@pos_g_x - 1] == 2 then	
					@sonnenblume.remove
					@feld[@pos_s_y][@pos_s_x] = 3
					
					@position_x = @position_x - 1	
					
					@feld[@pos_g_y][@pos_g_x] = 0 				 
					@pos_g_x = @pos_g_x - 1 	
					@giesskanne.remove							
					giesskanne_neu_setzen() 					
					@feld[@pos_g_y][@pos_g_x] = 3 
					alert "Du hast gewonnen!"
					clear
      				button "Spiel neu starten"
      				button "Spiel beenden"
			end
		end
		
		
	  
	  elsif key == :down then
		  
		if @feld[@position_y+1][@position_x] == 0 or 
			@feld[@position_y+1][@position_x] == 5 then
				@position_y = @position_y + 1
				
		elsif @feld[@position_y+1][@position_x] == 1 then
				@position_y = @position_y
				
		elsif @feld[@position_y+1][@position_x] == 3 then 
				
			if	@feld[@pos_g_y+1][@pos_g_x] == 0 then 
					@position_y = @position_y + 1
					
					@feld[@pos_g_y][@pos_g_x] = 0 				
					@pos_g_y = @pos_g_y + 1						
					@giesskanne.remove							
					giesskanne_neu_setzen( ) 					
					@feld[@pos_g_y][@pos_g_x] = 3 	
				
			elsif	@feld[@pos_g_y+1][@pos_g_x] == 5 then 
					@position_y = @position_y + 1
				
					@feld[@pos_g_y][@pos_g_x] = 0 				
					@pos_g_y = @pos_g_y + 1						
					@giesskanne.remove							
					giesskanne_neu_setzen( ) 					
					@feld[@pos_g_y][@pos_g_x] = 3 	
					alert "Game over!"	
					clear
      				button "Spiel neu starten"
      				button "Spiel beenden"		
			
			elsif @feld[@pos_g_y + 1][@pos_g_x] == 1 then	
					@position_x = @position_x
					@pos_g_y = @pos_g_y
			
			elsif @feld[@pos_g_y + 1][@pos_g_x] == 2 then	
					@sonnenblume.remove
					@feld[@pos_s_y][@pos_s_x] = 3
					
					@position_y = @position_y + 1				
				
					@feld[@pos_g_y][@pos_g_x] = 0 				 
					@pos_g_y = @pos_g_y + 1 	
					@giesskanne.remove							
					giesskanne_neu_setzen() 					
					@feld[@pos_g_y][@pos_g_x] = 3 
					alert "Du hast gewonnen!"
					clear
      				button "Spiel neu starten"
      				button "Spiel beenden"
			end
		
		end
	
	  
	  elsif key == :up then
		  
		if @feld[@position_y-1][@position_x] == 0 or
			@feld[@position_y-1][@position_x] == 5 then
				@position_y = @position_y - 1
		
		elsif 	@feld[@position_y-1][@position_x] == 1 then
					@position_y = @position_y
				
		elsif 	@feld[@position_y-1][@position_x] == 3 then 
				
			if	@feld[@pos_g_y-1][@pos_g_x] == 0 then 
			
					@position_y = @position_y - 1
					
					@feld[@pos_g_y][@pos_g_x] = 0 				
					@pos_g_y = @pos_g_y - 1						
					@giesskanne.remove							
					giesskanne_neu_setzen( ) 					
					@feld[@pos_g_y][@pos_g_x] = 3 		
				
			elsif	@feld[@pos_g_y-1][@pos_g_x] == 5 then 
					@position_y = @position_y - 1
				
					@feld[@pos_g_y][@pos_g_x] = 0 				
					@pos_g_y = @pos_g_y - 1						
					@giesskanne.remove							
					giesskanne_neu_setzen( ) 					
					@feld[@pos_g_y][@pos_g_x] = 3 
					alert "Game over!"
					clear
      				button "Spiel neu starten"
      				button "Spiel beenden"				
			
			elsif @feld[@pos_g_x][@pos_g_y - 1] == 1 then	
					@position_x = @position_x
					@pos_g_y = @pos_g_y
					
			elsif @feld[@pos_g_y - 1][@pos_g_x] == 2 then	
					@sonnenblume.remove
					@feld[@pos_s_y][@pos_s_x] = 3
					
					@position_y = @position_y - 1				
					
					@feld[@pos_g_y][@pos_g_x] = 0 				 
					@pos_g_y = @pos_g_y - 1 	
					@giesskanne.remove							
					giesskanne_neu_setzen() 					
					@feld[@pos_g_y][@pos_g_x] = 3 
					alert "Du hast gewonnen!"				
     				clear
      				button "Spiel neu starten"
      				button "Spiel beenden"
				end
			end
		end
		
  end	#Ende der Funktion bewegen
	  


 # Beim Druecken einer Taste soll nun die Funktion 'bewegen' aufgerufen werden.
 
 
  keypress do |i|
	  
	bewegen(i)
       @gaertner.move (@position_x * 50), (@position_y * 50)
       
  end	
	  
# Das Spiel geht auf Zeit, deswegen laeuft ein Timer ab!

  @seconds = 15
  @zeit = 0
  
  def display_zeit
	@display.clear do
		
      title "Restzeit: %02d:%02d" % [
        @seconds / 60 % 60,
        @seconds % 60
      ]
      
	end
  end

  @display = stack 
  

animate(1) do
    @seconds -= 1 
    if @seconds == -1 then
      alert "Zeit abgelaufen!"
      clear
      button "Spiel neu starten"
      button "Spiel beenden"
    end
    
    display_zeit
      
end	  
	  
	  
end #beendet app
