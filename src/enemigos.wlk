import wollok.game.*
import personaje.*

object enemigo1{
	var property position = game.at(5,5)
	var property velocidad = 1 //Se comporta raro con valores no enteros

	const property cooldown = 500 //Milisegundos entre movimientos
	method image() = "pepita.png" 
	
	method acercarse(objetivo) {
		if (objetivo.position().x() > self.position().x()) {
			position = position.right(velocidad)
		} else {
			position = position.left(velocidad)
		}
		
		if (objetivo.position().y() > self.position().y()) {
			position = position.up(velocidad)
		} else {
			position = position.down(velocidad)
		}
	}
	
	method tocarTiro() {
		game.removeVisual(self)
	}
}
class Enemigo2{
	
}