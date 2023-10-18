import wollok.game.*
import personaje.*

object enemigo1{
	
	const x = 0.randomUpTo(100) 
	const y = 0.randomUpTo(50)
	
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
	const x = 0.randomUpTo(100) 
	const y = 0.randomUpTo(50)
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
	var property position = enemigo2.position()
	const direccion = enemigo2.direccion()
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
		
		if(position.x() < 0 || position.x() > 150|| position.y() < 0|| position.y() > 100){
			self.eliminarTiro()
		}
		
	}

	method eliminarTiro() {
		game.removeVisual(self)
		game.removeTickEvent("moverFuego")
	}
	method tocarEnemigo(){}
}