import wollok.game.*
import enemigos.*

object personaje {
	var property position = game.center()
	var property direccion = "right"
	method cambiarDireccion(direccionNueva){
		direccion = direccionNueva
	}
	method image() = "personajev2.png"
	
	method disparar(){
		const tiro = new Proyectil()
		game.addVisual(tiro)
        game.onTick(10,"mover", {tiro.mover()})    
	}


}
class Proyectil {
	var property position = personaje.position()
	const direccion = personaje.direccion()
	method image() = "bala.png"
	method mover(){
		if(direccion == "right")
		position = position.right(1)
		else if (direccion == "left")
		position = position.left(1)
		else if (direccion == "up")
		position = position.up(1)
		else position = position.down(1)
		if(position.x() < 0 || position.x() > 150|| position.y() < 0|| position.y() > 100){
			game.removeVisual(self)
			game.removeTickEvent("mover")
		}
	}
	
}


