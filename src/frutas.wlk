import wollok.game.*
import personaje.*
import main.*
import direcciones.*

class Fruta{
	//Propiedades
	const direccion = right
	var property position = game.at(0.randomUpTo(40), 0.randomUpTo(15));
	
	//Metodos
	method image() = "cebolla.jpg"
	method aparecer(){
		game.addVisual(self);
	}
	
	method desaparecer(){
		if(game.hasVisual(self)){
			game.removeVisual(self);
		}
	}
	
	method retroceder(){
		direccion.moverse(self,-1)	
	}
	
	//Colisiones
	method tocarPersonaje(pj){
		self.tocarPersonaje(pj);
	}
	method tocarTiro(){
		self.desaparecer();
	}
	method tocarEnemigo(enemigo){}
	method tocarPiedra(piedra){}
}

class Banana inherits Fruta{
	override method image() = "banana.png"
	override method tocarPersonaje(pj){
		self.desaparecer();
		personaje.cambiarPuntuacion(45);
	}
}

class Manzana inherits Fruta{
	override method image() = "manzana.png"
	override method tocarPersonaje(pj){
		self.desaparecer();
		personaje.cambiarPuntuacion(5);
	}
}

class Cebolla inherits Fruta{
	override method image() = "cebolla.png"
	override method tocarPersonaje(pj){
		self.desaparecer();
		personaje.recibirDanio(1)
		personaje.cambiarPuntuacion(-45);
	}
}