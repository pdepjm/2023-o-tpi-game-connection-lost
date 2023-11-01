import wollok.game.*
import personaje.*


class Arena{
	method image() = "arena.png"
}

object piedra{
	var property velocidad = 1
	var property quieta = true
	var property position = game.at(15,15)
	method image() = "piedra.png"
	
	method tocarTiro() {
		game.onTick(100,"caer", {self.caer()}) 
		quieta = false
	}
	
	
	method caer() {
		position = position.down(velocidad)
		
		if (position.x() < 0 || position.x() > 150|| position.y() < 0|| position.y() > 100) {
			self.borrarse()
		}
		
		game.whenCollideDo(self, { elemento =>
		if (!quieta){
		elemento.tocarPiedra()
		}		
	}) 	
	}
	
	method borrarse(){
		game.removeVisual(self)
		game.removeTickEvent("caer")
	}
	method tocarEnemigo(){}
	method tocarFuego(){}
}