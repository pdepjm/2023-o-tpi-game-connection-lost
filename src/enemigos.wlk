import wollok.game.*
import personaje.*

object enemigo1{
	
	const x = 0.randomUpTo(game.width()) 
	const y = 0.randomUpTo(game.height())
	
	var property position = game.at(x,y)
	var property velocidad = 1 //Se comporta raro con valores no enteros
	var direccion = "right"
	const property cooldown = 500 //Milisegundos entre movimientos
	method image() = "enemigo1"+direccion+".png" 
	
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
	
	method tocarTiro() {
		game.removeVisual(self)		
	}
	method tocarFuego(){}
	
}
object enemigo2{
	const x = 0.randomUpTo(game.width()) 
	const y = 0.randomUpTo(game.height())
	var property estaVivo = true
	var property position = game.at(x,y)
	var property velocidad = 1 //Se comporta raro con valores no enteros
	var property direccion = "right"
	const property cooldown = 500 //Milisegundos entre movimientos
	method image() = "enemigo2"+direccion+".png" 
	
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
	method disparar(){
		if(estaVivo){
			const bala = new Fuego()
			game.addVisual(bala)
       		game.onTick(20, "moverFuego", {bala.mover()})      	
       		game.whenCollideDo(bala, { elemento =>
			if (elemento!= self){
				elemento.tocarFuego()
				bala.eliminarTiro()
				}		
			}) 		
		}	
	}
	method tocarFuego(){}
	method tocarTiro() {
		game.removeVisual(self)		
		estaVivo = false
	}

}

class Fuego{
	var property position = game.center()
	var property direccion = "right"
	method image() = "fuego2.png"
	method mover(){	
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
		
		if(position.x() < 0 || position.x() > game.width()|| position.y() < 0|| position.y() > game.height()){
			self.eliminarTiro()
		}
		game.onCollideDo(self,{algo => algo.tocarFuego()})
		
	}

	method eliminarTiro() {
		game.removeVisual(self)
		game.removeTickEvent("moverFuego")
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
	method image() = "enemigo2.png"
	
	//Metodos
	method aparecer(){
		position = game.at(0.randomUpTo(game.width()), 0.randomUpTo(game.height()))
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
			game.removeTickEvent("acercarse")
		}
	}
	method recibirDanio(cantidad) {
		vida -= cantidad
		if (vida == 0) self.desaparecer()
	}
	
	//Colisiones	
	method tocarPersonaje(){
		personaje.cambiarPosition(game.center())
		personaje.restarVida(1)
		if (personaje.vida() == 0) game.clear()
	}
	method tocarFuego(){}
	method tocarTiro(){self.recibirDanio(1)}
	method tocarPiedra() {self.recibirDanio(3)}
}

class Dragon inherits Enemigo{
	override method image() = "enemigo2"+direccion+".png"
	
	method disparar(){
          if(game.hasVisual(self)){
          	
          	// Esto hace que "position" del nuevo fuego sea igual a "position" de el dragon. 
          	// Debe hacerse así porque ambas posiciones tienen el mismo nombre
          	// PS: Termine haciendo lo mismo con direccion
          	const bala = new Fuego(position = position, direccion = direccion)
          	
			game.addVisual(bala)
       		game.onTick(20, "moverFuego", {bala.mover()})      	
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






