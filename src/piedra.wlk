import wollok.game.*
import personaje.*
import main.*

class Piedra{
	var property velocidad = 1
	var property quieta = true
	var property position = game.at(0.randomUpTo(40), 0.randomUpTo(19))
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
		if (main.dentroDePantalla(position)){
			self.borrarse()
		}else{
			position = position.down(velocidad)
			game.whenCollideDo(self, { elemento =>
			if (!quieta){
			elemento.tocarPiedra(self)
		}
	}) 	
		}
	
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
