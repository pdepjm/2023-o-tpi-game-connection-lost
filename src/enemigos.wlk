import wollok.game.*
import personaje.*
import main.*

class Fuego{
	var property position = null
	var property direccion = null
	var identificador = 0
	
	method cambiarIdentificador(nuevo){
		identificador = nuevo
	}
	method cambiarPosicion(posNueva){
		position = posNueva
	}
	method cambiarDireccion(nuevaDir){
		direccion = nuevaDir
	}
	
	method image() = "fuego2.png"
	method mover(){	
		if (game.hasVisual(self)){
		if(direccion == "right") {
		position = position.right(1)
		}
		else if(direccion == "left") {
		position = position.left(1)
		}
		if(direccion == "down") {
		position = position.down(1)
		}
		else if(direccion == "up") {
		position = position.up(1)
		}
		if(main.dentroDePantalla(self.position())){
			self.eliminarTiro(main.dragon1())
		}
		}
		
	}

	method eliminarTiro(tirador) {
		game.removeTickEvent("moverFuego"+tirador.identificador().toString())
		game.removeVisual(self)		
	}
	method tocarEnemigo(enemigo){}
	method tocarTiro(){}
}

class Enemigo{
	
	//Propiedades
	var position = game.at(0.randomUpTo(40), 0.randomUpTo(20))
	var direccion = "right"
	var vida = 1
	const velocidad = 1
	method direccion() = direccion
	method position() = position
	method cambiarPosicion(nuevaPos){
		position = nuevaPos
	}
	method image() = "enemigo2.png"
	
	//Metodos
	method aparecer(){
		if(self.position() == personaje.position()){
			self.aparecer()
		}else{
			game.addVisual(self)
			self.perseguirEnemigo()
		}
		
		game.whenCollideDo(self, { elemento =>
				elemento.tocarEnemigo(self)	
			}) 	
	}
	method perseguirEnemigo(){
		game.onTick(1000, "acercarse",{self.acercarse(personaje)})
	}
	method acercarse(objetivo) {
		const diferenciaX = objetivo.position().x() - self.position().x()
    	const diferenciaY = objetivo.position().y() - self.position().y()
		if (diferenciaX.abs() > diferenciaY.abs()) {
			if (diferenciaX > 0) {
	            position = position.right(velocidad)
	            direccion = "right"
	        } else {
	            position = position.left(velocidad)
	            direccion = "left"
	        }
    	}
    	else{
    		if (diferenciaY > 0) {
	            position = position.up(velocidad)
	            direccion = "up"
	        } else {
	            position = position.down(velocidad)
	            direccion = "down"
	        }
    	}
	
	}
	method desaparecer(){
		if(game.hasVisual(self)){
			game.removeVisual(self)
			main.cambiarCantidadEnemigos(-1)
		}
	}
	method recibirDanio(cantidad){
		vida -= cantidad
		if (vida <= 0){
			self.desaparecer()
		} 
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
	method tocarPersonaje(pj){pj.recibirDanio(1)}
	method tocarEnemigo(enemigo){}
	
	method tocarTiro(){
		self.recibirDanio(1)
		personaje.cambiarPuntuacion(100)
	}
	
	method tocarPiedra(piedra){
		self.recibirDanio(3)
		personaje.cambiarPuntuacion(300)
	}
}

class Dragon inherits Enemigo{
	var property identificador = 0
	
	method aumentarIdentificador(){
		identificador+=1
	}
	
	override method image() = "enemigo2"+direccion+".png"
	
	method disparar(){
      if(game.hasVisual(self)){
			const bala = new Fuego(position = position, direccion = direccion)
			game.addVisual(bala)
			game.onTick(20, "moverFuego"+identificador.toString(), {bala.mover()})      	
			game.whenCollideDo(bala, { elemento =>
				if (elemento!= self){
					elemento.tocarEnemigo(self)
					bala.eliminarTiro(self)
					self.aumentarIdentificador()
				}
			}) 	
      }
	}
	
	override method aparecer(){
		super()
		game.onTick(3000, "DisparoDragon",{self.disparar()})
	}		
}

class Pooka inherits Enemigo{
	override method image() = "enemigo1"+direccion+".png"
}





