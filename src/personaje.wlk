import wollok.game.*
import enemigos.*

object personaje {
	var property position = game.at(20,20)
	var property direccion = "right"
	
	method cambiarDireccion(direccionNueva){
		direccion = direccionNueva
	}
	method image() = "personaje_caminando_1.png"
	
	method disparar(){
			const tiro = new Proyectil()
			game.addVisual(tiro)
        	game.onTick(10,"mover", {tiro.mover()}) 
        	
        	game.whenCollideDo(tiro, {
			elemento =>
			elemento.tocarTiro()
			}) 
	}

	method tocarTiro() {}

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
		
		if(position.x() < 0 || position.x() > 150|| position.y() < 0|| position.y() > 100){
			game.removeVisual(self)
			game.removeTickEvent("mover")
		} else {}
	}
	
	
	method tocarTiro() {}
	
}


