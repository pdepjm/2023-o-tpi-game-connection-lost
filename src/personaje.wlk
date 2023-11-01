import wollok.game.*
import enemigos.*

object personaje {
	//Propiedades
	var property position = game.center()
	var property direccion = "right"
	var vida = 3
	method image() = "personaje"+direccion+".png"
	method vida() = vida
	
	//Metodos
	method cambiarPosition(nueva){
		position = nueva
	}
	method cambiarDireccion(direccionNueva){
		direccion = direccionNueva
	}
	method restarVida(cant){
		vida-=cant
	}
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
	method recibirDanio(cantidad) {
		position = game.center()
		vida -= cantidad
		if (vida == 0) game.clear()
	}
	//Colisiones
	method tocarTiro() {}
	method tocarFuego(){self.recibirDanio(1)}
	method tocarEnemigo(){self.recibirDanio(1)}
	method tocarPiedra() {self.recibirDanio(1)}

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
	method tocarFuego(){}
	method tocarPersonaje(){}
	method eliminarTiro() {
		game.removeVisual(self)
		game.removeTickEvent("mover")
	}
	
}


