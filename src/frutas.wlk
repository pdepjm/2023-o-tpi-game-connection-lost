import wollok.game.*
import personaje.*
import main.*

class Fruta{
	//Propiedades
	const position = game.center();
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
			game.onTick(2000, "aparecer fruta", {fruta.aparecer()});
		}
	}
	
	//Colisiones
	method tocarPersonaje(pj){
		fruta.tocarPersonaje(pj);
	}
	method tocarTiro(){
		self.desaparecer();
	}
	method tocarEnemigo(enemigo){}
	method tocarPiedra(piedra){}
}

object banana inherits Fruta{
	override method image() = "banana.png"
	override method tocarPersonaje(pj){
		self.desaparecer();
		personaje.cambiarPuntuacion(545);
	}
}

object manzana inherits Fruta{
	override method image() = "manzana.png"
	override method tocarPersonaje(pj){
		self.desaparecer();
		personaje.cambiarPuntuacion(5);
	}
}

object cebolla inherits Fruta{
	override method image() = "cebolla.png"
	override method tocarPersonaje(pj){
		self.desaparecer();
		personaje.recibirDanio(1)
		personaje.cambiarPuntuacion(-45);
	}
}