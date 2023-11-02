import wollok.game.*
import personaje.*
import enemigos.*
import piedra.*
import graficos.*
import arena.*

object main {
	
	
	method iniciar(){
	const altura = 20
	const anchura = 40
	
	game.cellSize(32)
	game.width(anchura)
	game.height(altura)
	game.boardGround("fondo.png")
	game.title("Dig Dug")
	
	//Declarar Objetos
	const dragon1 = new Dragon()
	const pooka1 = new Pooka()
	const pooka2 = new Pooka()
	const pooka3 = new Pooka()
	const piedra1 = new Piedra()
	const piedra2 = new Piedra()
	const piedra3 = new Piedra()
	const piedra4 = new Piedra()
	const piedra5 = new Piedra()

		
	//Spawnear Objetos
	game.addVisual(personaje)
	game.schedule(0.randomUpTo(20000),{dragon1.aparecer()})
	pooka1.aparecer()
	pooka2.aparecer()
	pooka3.aparecer()
	piedra1.aparecer()
	piedra2.aparecer()
	piedra3.aparecer()
	piedra4.aparecer()
	piedra5.aparecer()
	vida.aparecer()
	self.agregarPooka()
	
	//Inputs
	keyboard.left().onPressDo({personaje.cambiarDireccion("left")})
	keyboard.right().onPressDo({personaje.cambiarDireccion("right")})
	keyboard.up().onPressDo({personaje.cambiarDireccion("up")})
	keyboard.down().onPressDo({personaje.cambiarDireccion("down")})
	keyboard.z().onPressDo({personaje.disparar()})
	keyboard.x().onPressDo({personaje.ponerArena()})
		
	//Colision Protagonista
	game.onCollideDo(personaje, {objeto => objeto.tocarPersonaje()})
	
	//Terminacion Juego
	game.schedule(30000, {=>self.terminarJuego()})
	
	}
	method agregarPooka() {
		game.onTick(2000,"agregar pooka",{new Pooka().aparecer()}) 
		
	}
	
	method terminarJuego(){
		game.clear()
		game.addVisual(gameOver)
		game.addVisual(score)
		game.addVisual(puntaje)
	}
	
}
