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
		fruta = [manzana, banana, cebolla].anyOne()
		game.onTick(4000, "desaparecer fruta", {self.desaparecer()})
		game.addVisual(self);
	}
	
	method desaparecer(){
		if(game.hasVisual(self)){
			game.removeTickEvent("desaparecer fruta");
			game.removeVisual(self);
		}
	}
	
	//Colisiones
	method tocarPersonaje(){
		self.desaparecer();
	}
	method tocarTiro(){}
}

object banana inherits Fruta{
	override method image() = "banana.png"
	override method tocarPersonaje(){
		super();
		personaje.cambiarPuntuacion(45);
	}
}

object manzana inherits Fruta{
	override method image() = "manzana.png"
	override method tocarPersonaje(){
		super();
		personaje.restarVida(-1);
	}
}

object cebolla inherits Fruta{
	override method image() = "cebolla.png"
	override method tocarPersonaje(){
		super();
		personaje.restarVida(1)
		personaje.cambiarPuntuacion(-45);
	}
}