import wollok.game.*
import enemigos.*

object personaje {
	var property position = game.center()
	var property direccion = "right"
	var vida = 3
	
	method cambiarPosition(nueva){
		position = nueva
	}
	method cambiarDireccion(direccionNueva){
		direccion = direccionNueva
	}
	method vida() = vida
	method restarVida(cant){
		vida-=cant
	}
	method image() = "personaje"+direccion+".png"

	
	method disparar(){
			const tiro = new Proyectil()
			game.addVisual(tiro)
        	game.onTick(10,"mover", {tiro.mover()})      	
        	game.whenCollideDo(tiro, { elemento =>
				if (elemento!= self){
					elemento.tocarTiro()
					tiro.eliminarTiro()	
				}		
			}) 	
	}
	
	
	method tocarTiro() {}
	method tocarFuego(){
		position = game.center()
		vida -= 1
		if (vida == 0) game.clear()
	}
	method tocarEnemigo(){
		position = game.center()
		vida -= 1
		if (vida == 0) game.clear()
	}

}
class Proyectil {
	var property position = personaje.position()
	const direccion = personaje.direccion()
	method image() = "bala.png"
	method mover(){
		
		if(direccion == "right") {
		position = position.right(1)
		}
		if(direccion == "down") {
		position = position.down(1)
		}
		if(direccion == "up") {
		position = position.up(1)
		}
		if(direccion == "left") {
		position = position.left(1)
		}
		
		if(position.x() < 0 || position.x() > game.width()|| position.y() < 0|| position.y() > game.height()){
			self.eliminarTiro()
		}
		
	}
	
	method tocarPersonaje(){}
	method eliminarTiro() {
		game.removeVisual(self)
		game.removeTickEvent("mover")
	}
	
}


