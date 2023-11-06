import wollok.game.*
import enemigos.*
import arena.*
import main.*

object personaje {
	//Propiedades
	var property position = game.center()
	var property direccion = "right"
	var property identificador = 0
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
		
		if (main.dentroDePantalla(self.position())) {
			self.retroceder()
		}
	}
	method disparar(){
			const tiro = new Proyectil()
			identificador+=1
			game.addVisual(tiro)
        	game.onTick(10,"moverTiro"+self.identificador().toString(), {tiro.mover()})
        	tiro.cambiarIdentificador(identificador)     	
        	game.whenCollideDo(tiro, { elemento =>
				if (elemento!= self){
					elemento.tocarTiro()
					tiro.eliminarTiro()	
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
		if (vida <= 0) main.terminarJuego()
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
	method tocarEnemigo(enemigo){self.recibirDanio(1)}
	method tocarPiedra(piedra) {self.recibirDanio(1)}

}

class Proyectil {
	var  identificador = 0
	//Propiedades
	var property position = personaje.position()
	
	const direccion = personaje.direccion()
	method image() = "bala.png"
	
	//Metodos
	
	method cambiarIdentificador(nuevo){
		identificador = nuevo
	}
	
	method mover(){
		
		if(main.dentroDePantalla(self.position())){
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
	
	method tocarPersonaje(personaje){}
	method tocarEnemigo(a){}
	method eliminarTiro() {
		game.removeTickEvent("moverTiro"+identificador.toString())
		game.removeVisual(self)
		
	}
	
}



