import wollok.game.*
import personaje.*
import enemigos.*
import piedra.*
import graficos.*
import arena.*

object main {
	var cantEnemigos = 5
	method cantEnemigos() = cantEnemigos
	method restarEnemigos(){
		cantEnemigos -= 1
		if (cantEnemigos <= 0){
			self.terminarJuego()
		}
	}
	method iniciar(){
	const altura = 20
	const anchura = 40
	
	game.cellSize(32)
	game.width(anchura)
	game.height(altura)
	game.boardGround("fondo.png")
	game.title("Juego Base")
	
	//Declarar Objetos
	const dragon1 = new Dragon(position = game.at(1,1))
	const pooka1 = new Pooka(position = game.at(40,15))
	const pooka2 = new Pooka(position = game.at(18,7))
	const pooka3 = new Pooka(position = game.at(40,19))
	const pooka4 = new Pooka(position = game.at(5,19))
	const piedra1 = new Piedra(position = game.at(15,15))
	const arenaTest = new Arena(position = game.at(15,5))
		
	//Spawnear Objetos
	game.addVisual(personaje)
	dragon1.aparecer()
	pooka1.aparecer()
	pooka2.aparecer()
	pooka3.aparecer()
	pooka4.aparecer()
	vida.aparecer()
	arenaTest.aparecer()
	piedra1.aparecer()
	
	//Inputs
	keyboard.left().onPressDo({personaje.cambiarDireccion("left")})
	keyboard.right().onPressDo({personaje.cambiarDireccion("right")})
	keyboard.up().onPressDo({personaje.cambiarDireccion("up")})
	keyboard.down().onPressDo({personaje.cambiarDireccion("down")})
	keyboard.z().onPressDo({personaje.disparar()})
		
	//Colision Protagonista
	game.onCollideDo(personaje, {objeto => objeto.tocarPersonaje()})
	
	}
	method terminarJuego(){
		game.clear()
		game.addVisual(gameOver)
		game.addVisual(score)
		game.addVisual(puntaje)
	}
	
}
