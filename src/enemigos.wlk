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
	
}
object enemigo2{
	const x = 0.randomUpTo(100) 
	const y = 0.randomUpTo(50)
	
	var property position = game.at(x,y)
	var property velocidad = 1 //Se comporta raro con valores no enteros
	var direccion = "right"
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
	
	method tocarTiro() {
		game.removeVisual(self)		
	}

	
}