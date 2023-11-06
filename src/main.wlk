import wollok.game.*
import personaje.*
import enemigos.*
import piedra.*
import graficos.*
import arena.*

object main {
	const altura = 20
	const anchura = 40
	const dragon1 = new Dragon(vida = 3)
	var cantidadEnemigos = 4
	
	method dentroDePantalla(position) {
		return (position.x() < 0 || position.x() > anchura || position.y() < 0|| position.y() > altura )
	}
	
	method cambiarCantidadEnemigos(numero) {
		cantidadEnemigos += numero
	}	
	
	method dragon1() = dragon1
	
	method iniciar(){
	
	game.cellSize(32)
	game.width(anchura)
	game.height(altura)
	game.boardGround("fondo.png")
	game.title("Dig Dug")
	
	//Declarar Objetos


	3.times({x => new Pooka().aparecer()})
	
	5.times({x =>new Piedra().aparecer()})
		
	//Spawnear Objetos
	game.addVisual(personaje)
	game.schedule(0.randomUpTo(20000),{dragon1.aparecer()})

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
	game.onCollideDo(personaje, {objeto => objeto.tocarPersonaje(personaje)})
	
	//Terminacion Juego
	game.schedule(30000, {=>self.terminarJuego()})
	
	}
	method agregarPooka() {
		game.onTick(2000,"agregar pooka",{
			if (cantidadEnemigos < 10) {
				new Pooka().aparecer()
				self.cambiarCantidadEnemigos(1)
			}
		}) 
		
	}
	
	method terminarJuego(){
		game.clear()
		game.addVisual(gameOver)
		game.addVisual(score)
		game.addVisual(puntaje)
	}
	
}
