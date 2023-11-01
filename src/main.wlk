import wollok.game.*
import personaje.*
import enemigos.*
import piedra.*
import graficos.*

object main {
	method iniciar(){
	const altura = 20
	const anchura = 40
	
	game.cellSize(32)
	game.width(anchura)
	game.height(altura)
	game.boardGround("fondo.png")
	game.title("Juego Base")
	
	const dragon1 = new Dragon()
	const pooka1 = new Pooka()
	const pooka2 = new Pooka()
	const pooka3 = new Pooka()
	const pooka4 = new Pooka()
	const piedra1 = new Piedra()
		
	pooka1.cambiarPosicion(game.at(8,18))
	pooka2.cambiarPosicion(game.at(21,15))
	pooka3.cambiarPosicion(game.at(32,5))
	pooka4.cambiarPosicion(game.at(32,16))
	dragon1.cambiarPosicion(game.at(11,7))
	
	game.addVisual(piedra1)
	game.addVisualCharacter(personaje)
	dragon1.aparecer()
	pooka1.aparecer()
	pooka2.aparecer()
	pooka3.aparecer()
	pooka4.aparecer()
	vida.aparecer()
		
	keyboard.left().onPressDo({personaje.cambiarDireccion("left")})
	keyboard.right().onPressDo({personaje.cambiarDireccion("right")})
	keyboard.up().onPressDo({personaje.cambiarDireccion("up")})
	keyboard.down().onPressDo({personaje.cambiarDireccion("down")})
	keyboard.z().onPressDo({personaje.disparar()})
		
	game.onCollideDo(personaje, {objeto => objeto.tocarPersonaje()})
	
	}
	
}
