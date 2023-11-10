object right {
	method nombre() = "right"
	method moverse(persona,velocidad){
		persona.cambiarPosition(persona.position().right(velocidad))
		persona.cambiarDireccion(self)	
	}
}
object left {
	method nombre() = "left"
	method moverse(persona,velocidad){
		persona.cambiarPosition(persona.position().left(velocidad))	
		persona.cambiarDireccion(self)
	}
}
object up {
	method nombre() = "up"
	method moverse(persona,velocidad){
		persona.cambiarPosition(persona.position().up(velocidad))	
		persona.cambiarDireccion(self)
	}
}
object down {
	method nombre() = "down"
	method moverse(persona,velocidad){
		persona.cambiarPosition(persona.position().down(velocidad))
		persona.cambiarDireccion(self)	
	}
}