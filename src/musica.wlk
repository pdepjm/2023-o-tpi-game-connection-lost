import wollok.game.*


object sonidos {
	const musicaFondo = game.sound("Musica.mp3")
	const sfx = game.sound("Game Over.mp3")
		
	method musica() {
		musicaFondo.shouldLoop(false)
		musicaFondo.play()
	}
	
	method pararMusica() {
		//musicaFondo.stop()
		musicaFondo.volume(0)
	}
	
	method gameOver() {
		sfx.shouldLoop(false)
		sfx.play()
	}
}