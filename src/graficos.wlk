import wollok.game.*
import personaje.*
import enemigos.*
import piedra.*

object vida {
	method position() = game.at(37,19)
	
	method image(){
		return if(personaje.vida()==3) "3corazones.PNG"
			   else if(personaje.vida()==2)"2corazones.PNG"
			   else if(personaje.vida()==1)"1corazon.PNG"
	}
	
	method aparecer(){
		game.addVisual(self)
	}
	method tocarEnemigo(enemigo){}
	
}
object gameOver{
	method position() = game.at(4,4)
	method image() = "game over.png"
}
object score{
	method position() = game.at(17,3)
	method image() = "score.png"
}
object puntaje{
	method position() = game.at(19,1)
	method text() = personaje.puntuacion().toString()
	method textColor() = "FFFFFFF"
}