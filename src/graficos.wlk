import wollok.game.*
import personaje.*
import enemigos.*
import piedra.*

object vida {
	method position() = game.at(10,0)
	
	method text() {
		return if (personaje.vida() == 3) "Cantidad de vidas = 3"
		else if (personaje.vida() == 2) "Cantidad de vidas = 2"
		else "Cantidad de vidas = 1"
	} 
	
	method textColor() = "FFFFFFF"
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