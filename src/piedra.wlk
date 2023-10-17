import wollok.game.*
import personaje.*

object piedra{
	var property velocidad = 1
	var property position = game.at(15,15)
	method image() = "piedra.png"
	
	method tocarTiro() {
		game.onTick(10,"caer", {self.caer()}) 
	}
	
	method caer() {
		position = position.down(velocidad)
		
		if (position.x() < 0 || position.x() > 150|| position.y() < 0|| position.y() > 100) {
			game.removeVisual(self)
			game.removeTickEvent("caer")
		}
	}
}