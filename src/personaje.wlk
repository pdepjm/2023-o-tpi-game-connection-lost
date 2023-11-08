import wollok.game.*
import enemigos.*
import arena.*
import main.*
import direcciones.*

object personaje {
	//Propiedades
	var property position = game.center()
	var property direccion = right
	var property identificador = 0
	var vida = 3
	var puntuacion = 0
	method image() = "personaje"+direccion.nombre()+".png"
	method vida() = vida
	method puntuacion() = puntuacion
	method velocidad() = 1
	
	//Metodos
	
	method cambiarPuntuacion(puntos){
		puntuacion += puntos
	}
	method cambiarPosition(nueva){
		position = nueva
	}
	method cambiarDireccion(direccionNueva){
		direccion = direccionNueva
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
		direccion.moverse(self,-1)	
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
	
	var direccion = personaje.direccion()
	method cambiarPosition(nueva){
		position = nueva
	}
	method cambiarDireccion(direccionNueva){
		direccion = direccionNueva
	}
	method image() = "bala.png"
	
	//Metodos
	
	method cambiarIdentificador(nuevo){
		identificador = nuevo
	}
	
	method mover(){
		
		if(main.dentroDePantalla(self.position())){
			self.eliminarTiro()
		}
		direccion.moverse(self,1)
		
	}
	
	method tocarPersonaje(personaje){}
	method tocarEnemigo(a){}
	method eliminarTiro() {
		game.removeTickEvent("moverTiro"+identificador.toString())
		game.removeVisual(self)
		
	}
	
}



