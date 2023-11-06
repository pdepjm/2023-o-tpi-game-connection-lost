import wollok.game.*
import personaje.*
import main.*

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
		
		if (main.dentroDePantalla(self.position())) {
			self.borrarse()
		}
		
		game.whenCollideDo(self, { elemento =>
		if (!quieta){
		elemento.tocarPiedra(self)
		}
	}) 	
	}
	
	method borrarse(){
		self.detenerse()
		game.removeVisual(self)
	}
	method tocarEnemigo(enemigo){}
	method tocarPersonaje(pj){}
	method tocarPiedra(piedra){}
	method retroceder() {}
}
