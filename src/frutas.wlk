import wollok.game.*
import personaje.*
import main.*

class Fruta{
	//Propiedades
	const position = game.at(0,0);
	var property fruta = [manzana, banana, cebolla].anyOne();
	
	//Metodos
	method image() = fruta.image();
	method position() = position;
	method aparecer(){
		game.addVisual(fruta);
	}
	
	method desaparecer(){
		if(game.hasVisual(fruta)){
			game.removeVisual(fruta);
		}
	}
	
	//Colisiones
	method tocarPersonaje(){}
	method tocarTiro(){}
}

object banana inherits Fruta{
	override method image() = "banana.png"
	override method tocarPersonaje(){
		personaje.cambiarPuntuacion(45);
		self.desaparecer();
	}
}

object manzana inherits Fruta{
	override method image() = "manzana.png"
	override method tocarPersonaje(){
		personaje.restarVida(-1);
		self.desaparecer();
	}
}

object cebolla inherits Fruta{
	override method image() = "cebolla.png"
	override method tocarPersonaje(){
		personaje.restarVida(1)
		personaje.cambiarPuntuacion(-45)
		self.desaparecer();
	}
}