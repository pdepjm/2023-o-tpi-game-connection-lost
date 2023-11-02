import wollok.game.*
import enemigos.*
import arena.*

object personaje {
	//Propiedades
	var property position = game.center()
	var property direccion = "right"
	var vida = 3
	var puntuacion = 0
	method image() = "personaje"+direccion+".png"
	method vida() = vida
	method puntuacion() = puntuacion
	
	//Metodos
	method cambiarPuntuacion(puntos){
		puntuacion += puntos
	}
	method cambiarPosition(nueva){
		position = nueva
	}
	method cambiarDireccion(direccionNueva){
		direccion = direccionNueva
		if (direccion == "up") {
			position = position.up(1)
		}
		if (direccion == "down") {
			position = position.down(1)
		}
		if (direccion == "left") {
			position = position.left(1)
		}
		if (direccion == "right") {
			position = position.right(1)
		}
	}
	method restarVida(cant){
		vida-=cant
	}
	method disparar(){
			const tiro = new Proyectil()
			game.addVisual(tiro)
        	game.onTick(10,"moverTiro"+tiro.identificador().toString(), {tiro.mover()})      	
        	game.whenCollideDo(tiro, { elemento =>
				if (elemento!= self){
					elemento.tocarTiro()
					tiro.eliminarTiro()	
					tiro.aumentarIdentificador()
				}		
			}) 	
	}
	method ponerArena(){
		const arena = new Arena(position = position)
		arena.aparecer()
		self.cambiarPuntuacion(-1)
	}
		
	method recibirDanio(cantidad) {
		position = game.center()
		vida -= cantidad
		if (vida == 0) game.clear()
	}
	method retroceder() {
		if (direccion == "up") {
			position = position.down(1)
			direccion = "up"
		}
		if (direccion == "down") {
			position = position.up(1)
		}
		if (direccion == "left") {
			position = position.right(1)
		}
		if (direccion == "right") {
			position = position.left(1)
		}
	}
	
	
	
	//Colisiones
	method tocarTiro() {}
	method tocarEnemigo(){self.recibirDanio(1)}
	method tocarPiedra() {self.recibirDanio(1)}

}

class Proyectil {
	
	//Propiedades
	var property position = personaje.position()
	var property identificador = 0
	const direccion = personaje.direccion()
	method image() = "bala.png"
	
	//Metodos
	method aumentarIdentificador(){
		identificador+=1
	}

	method mover(){
		
		if(position.x() < 0 || position.x() > game.width()|| position.y() < 0|| position.y() > game.height()){
			self.eliminarTiro()
		}
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
		
	}
	
	method tocarPersonaje(){}
	method eliminarTiro() {
		game.removeTickEvent("moverTiro"+identificador.toString())
		game.removeVisual(self)
		
	}
	
}



