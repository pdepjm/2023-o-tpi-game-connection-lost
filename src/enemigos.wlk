import wollok.game.*
import personaje.*
import main.*
import direcciones.*
import graficos.*

class Fuego{
	var property position = null
	var property direccion = right
	var identificador = 0

	
	method cambiarIdentificador(nuevo){
		identificador = nuevo
	}
	method cambiarPosition(posNueva){
		position = posNueva
	}
	method cambiarDireccion(nuevaDir){
		direccion = nuevaDir
	}
	
	method image() = "fuego2.png"
	method mover(){	
		if (game.hasVisual(self)){
		direccion.moverse(self,1)
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
	method tocarPersonaje(){}
}

class Enemigo{
	
	//Propiedades
	var position = game.at(0.randomUpTo(40), 0.randomUpTo(15))
	var direccion = right
	var vida = 1
	method vida(){
		if (vida > 0) return vida
		else return 0
	} 
	method direccion() = direccion
	method position() = position
	method cambiarPosition(nuevaPos){
		position = nuevaPos
	}
	method cambiarDireccion(nuevaDir){
		direccion = nuevaDir
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
	            right.moverse(self,1)
	        } else {
	            left.moverse(self,1)
	        }
    	}
    	else{
    		if (diferenciaY > 0) {
	           up.moverse(self,1)
	        } else {
	            down.moverse(self,1)
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
		direccion.moverse(self,-1)	
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
	
	override method image() = "enemigo2"+direccion.nombre()+".png"

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
		game.addVisual(vidaDragon) 
		game.onTick(3000, "DisparoDragon",{self.disparar()})
	}		
}

class Pooka inherits Enemigo{
	override method image() = "enemigo1"+direccion.nombre()+".png"
}





