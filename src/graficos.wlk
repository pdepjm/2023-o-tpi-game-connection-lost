import wollok.game.*
import personaje.*
import enemigos.*
import piedra.*
import main.*

object vida {
	method position() = game.at(37,19)
	
	method image() = "corazon"+personaje.vida().toString()+".PNG" 
		
	
	method aparecer(){
		game.addVisual(self)
	}
	method tocarEnemigo(enemigo){}
	method tocarTiro(){}
	method retroceder(){}
}
object vidaDragon{
	method position() = game.at(2,19)
	method image() = "corazonVerde" + main.dragon1().vida().toString() + ".PNG"
	method tocarEnemigo(enemigo){}
	method tocarTiro(){}
	method retroceder(){}
}
object gameOver{
	method position() = game.at(0,0)
	method image() = "game over.png"
}
object score{
	method position() = game.at(17,2)
	method image() = "score.png"
}
object puntaje{
	method position() = game.at(19,0)
	method text() = personaje.puntuacion().toString()
	method textColor() = "FFFFFFF"
}