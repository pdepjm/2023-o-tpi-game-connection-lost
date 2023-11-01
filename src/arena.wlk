import wollok.game.*
import personaje.*

class Arena {
    // Propiedades
    var property position = null
    var vida = 1
    
    // Métodos
    method cambiarPosition(nueva){
		position = nueva
	}
    method aparecer() {
        game.addVisual(self)
        game.whenCollideDo(self, { elemento =>
			if (elemento.image() != "piedra.png"){
				elemento.retroceder()
				}		
			}) 	
    }    
    method image() = "arena.png"
    method recibirDanio(cantidad) {
        vida -= cantidad
        if (vida <= 0) self.desaparecer()
    }
    method desaparecer(){
		if(game.hasVisual(self)){
			game.removeVisual(self)
		}
	}
    
    // Colisiones
    method tocarPersonaje() {
    }   
    method tocarTiro() {self.recibirDanio(1)}
    method tocarFuego() {}
    method tocarPiedra() {
    	self.recibirDanio(1)
    }
}
