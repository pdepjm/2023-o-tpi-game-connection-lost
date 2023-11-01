import wollok.game.*
import personaje.*

class Fuego{
	var property position = null
	var property direccion = null
	var property identificador = 0
	method cambiarPosicion(posNueva){
		position = posNueva
	}
	method cambiarDireccion(nuevaDir){
		direccion = nuevaDir
	}
	method aumentarIdentificador(){
		identificador+=1
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
		if(position.x() <= 0 || position.x() >= game.width()|| position.y() <= 0|| position.y() >= game.height()){
			self.eliminarTiro()
		}
		}
		game.onCollideDo(self,{algo => algo.tocarFuego()})	
	}

	method eliminarTiro() {
		game.removeTickEvent("moverFuego"+identificador)
		game.removeVisual(self)		
	}
	method tocarEnemigo(){}
}

class Enemigo{
	
	//Propiedades
	var position = null
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
		game.addVisual(self)
		self.perseguirEnemigo()
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
		}
	}
	method recibirDanio(cantidad){
		vida -= cantidad
		if (vida <= 0) self.desaparecer()
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
	method tocarPersonaje(){
		personaje.cambiarPosition(game.center())
		personaje.restarVida(1)
		if (personaje.vida() == 0) game.clear()
	}
	method tocarTiro(){
		self.recibirDanio(1)
	}
	method tocarFuego(){}
	method tocarPiedra(){
		self.recibirDanio(3)
	}
}

class Dragon inherits Enemigo{
	override method image() = "enemigo2"+direccion+".png"
	
	method disparar(){
          if(game.hasVisual(self)){
          	// Esto hace que "position" del nuevo fuego sea igual a "position" de el dragon. 
          	// Debe hacerse así porque ambas posiciones tienen el mismo nombre
          	// PS: Termine haciendo lo mismo con direccion
          	const bala = new Fuego(position = position, direccion = direccion)
			bala.aumentarIdentificador()
			game.addVisual(bala)
       		game.onTick(20, "moverFuego"+bala.identificador(), {bala.mover()})      	
       		game.whenCollideDo(bala, { elemento =>
			if (elemento!= self){
				elemento.tocarFuego()
				bala.eliminarTiro()
				}		
			}) 	
          }	
		}
	override method aparecer(){
		super()
		game.onTick(10000, "DisparoDragon",{self.disparar()})
	}		
	}

class Pooka inherits Enemigo{
	override method image() = "enemigo1"+direccion+".png"
}





