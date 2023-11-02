import wollok.game.*
import personaje.*

class Piedra{
	var property velocidad = 1
	var property quieta = true
	var property position = game.at(0.randomUpTo(40), 0.randomUpTo(20))
	method image() = "piedra.png"
	
	method aparecer() {
        game.addVisual(self)
        game.whenCollideDo(self, { elemento =>
			if (quieta){
			elemento.retroceder()
			}	
		}) 	
    }   	
	method tocarTiro() {
		game.onTick(100,"caer", {self.caer()}) 
		quieta = false
	}
	method detenerse(){
		game.removeTickEvent("caer")
		quieta = true
	}
	method caer() {
		position = position.down(velocidad)
		
		if (position.x() < 0 || position.x() > game.width()|| position.y() < 0|| position.y() > game.height()) {
			self.borrarse()
		}
		
		game.whenCollideDo(self, { elemento =>
		if (!quieta){
		elemento.tocarPiedra()
		}		
		if (elemento.image() == "arena.png") {
			self.detenerse()
		}
	}) 	
	}
	
	method borrarse(){
		self.detenerse()
		game.removeVisual(self)
	}
	method tocarEnemigo(){}
	method tocarFuego(){}
	method tocarPersonaje(){}
	method tocarPiedra(){}
}
