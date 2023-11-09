import wollok.game.*
import personaje.*
import enemigos.*
import piedra.*
import graficos.*
import arena.*
import frutas.*
import direcciones.*
import musica.*


object main {
	const altura = 20
	const anchura = 40
	const dragon1 = new Dragon(vida = 5)
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
	
	5.times({x => new Piedra().aparecer()})
	
	//20.times({x => new Arena().aparecer() })
	//Spawnear Objetos
	game.addVisual(personaje)
	game.schedule(0.randomUpTo(20000),{dragon1.aparecer()})

	vida.aparecer()
	self.agregarPooka()
	self.aparecerFruta()
	//Inputs
	keyboard.left().onPressDo({left.moverse(personaje,1)})
	keyboard.right().onPressDo({right.moverse(personaje,1)})
	keyboard.up().onPressDo({up.moverse(personaje,1)})
	keyboard.down().onPressDo({down.moverse(personaje,1)})
	keyboard.z().onPressDo({personaje.disparar()})
	keyboard.x().onPressDo({personaje.ponerArena()})
	
	//Musica
	game.schedule(10, {sonidos.musica()})
		
	//Colision Protagonista
	game.onCollideDo(personaje, {objeto => objeto.tocarPersonaje(personaje)})
	
	//Terminacion Juego
	game.schedule(30000, {=>self.terminarJuego()})
	
	}
	method aparecerFruta(){
		
		game.onTick(5000, "agregarFruta",
			{const coleccionFrutas = [new Banana(), new Manzana(), new Cebolla()]
			const fruta = coleccionFrutas.anyOne()
			fruta.aparecer()})
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
		sonidos.pararMusica()
		sonidos.gameOver()
	}
	
}
