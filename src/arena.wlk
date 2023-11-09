import wollok.game.*
import personaje.*

class Arena {
    // Propiedades
    var property position = game.at(0.randomUpTo(40), 0.randomUpTo(19))
    var vida = 1
    
    // Métodos
    method cambiarPosition(nueva){position = nueva}
    method aparecer() {game.addVisual(self)}    
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
    method tocarPersonaje(pj) {pj.retroceder()}
    method tocarEnemigo(enemigo){enemigo.retroceder()} 
    method tocarTiro() {self.recibirDanio(1)}
    method retroceder(){}
    
    method tocarPiedra(piedra) {
    	self.recibirDanio(1)
    	piedra.detenerse()
    }
}
