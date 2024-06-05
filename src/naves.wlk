class Nave {
	var velocidad = 0
	var direccion = 0
	var combustible = 0
	
	method initialize(){
		if (not direccion.between(-10,10)) self.error("direccion incorrecta")
	}
	
	method acelerar(cuanto){
		velocidad = 100000.min(velocidad + cuanto)
	}
	
	method desacelerar(cuanto){
		velocidad = 0.max(velocidad - cuanto)
	}
	
	method estaTranquila() = combustible >= 400 && velocidad < 12000
	
	
	method irHaciaElSol(){
		direccion = 10
	}
	
	method escaparDelSol(){
		direccion = -10
	}
	
	method ponerseParaleloAlSol(){
		direccion = 0
	}
	
	method acercarseUnPocoAlSol(){
		direccion = 10.min(direccion + 1)
	}
	
	method alejarseUnPocoDelSol(){
		direccion = (-10).max(direccion - 1)
	}
	
	method cargarCombustible(unaCantidad){
		combustible += unaCantidad
	}
	
	method descargarCombustible(unaCantidad){
		combustible -= unaCantidad
	}
	
	method accionAdicional(){
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	
	method prepararViaje()
	
}

class Baliza inherits Nave {
	var color
	method initialize(){
		self.validarColores(color)
	}
	
	method validarColores(unColor) {
		if(["rojo", "verde", "azul"].contains(unColor)) self.error("Color no valido")
	}
	method cambiarColorDeBaliza(nuevoColor){
		self.validarColores(nuevoColor)
		color = nuevoColor
	} 
	
	override method prepararViaje(){
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
		self.accionAdicional()
	}
	override method estaTranquila() = super() && color != "rojo"
}

class Pasajero inherits Nave{
	var property cantidadPasajeros = 0
	var racionesComida = 0
	var bebidas = 0
	method racionesComida(unaCantidad){
		racionesComida += unaCantidad 
	}
	
	method bebidas(unaCantidad){
		bebidas += unaCantidad
		//agregar 0.max 
	}
	
	method cargarComida(unaCantidad){
		racionesComida -= unaCantidad 
		//agregar 0.max
	}
	
	method descargarBebidas(unaCantidad){
		bebidas -= unaCantidad 
	}
	
	override method prepararViaje(){
		self.racionesComida(4 * cantidadPasajeros)
		self.bebidas(6 * cantidadPasajeros)
		self.acercarseUnPocoAlSol()
		self.accionAdicional()
	}  
}

class Combate inherits Nave {
	var visible = true
	var misilesDesplegados = false
	const mensajesEmitidos = []
	
	method ponerseVisible() {
		visible = true
	}
	
	method ponerseInvisible(){
		visible = false
	}
	
	method estaInvisible() = not visible
	
	method desplegarMisiles(){
		misilesDesplegados = true
	}
	method replegarMisiles(){
		misilesDesplegados = false
	}
	method misilesDesplegables() = misilesDesplegados
	
	method emitirMensaje(unMensaje){
		mensajesEmitidos.add(unMensaje)
	}
	method mensajesEmitidos() = mensajesEmitidos
	method primerMensajeEmitido() = mensajesEmitidos.first()
	method ultimoMensajeEmitido() = mensajesEmitidos.last()
	method emitioMensaje(unMensaje) = mensajesEmitidos.contains(unMensaje)
	method esEscueta() = mensajesEmitidos.all{mensaje => mensaje.size() <= 30}
	
	override method prepararViaje() {
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misiòn")
		self.accionAdicional()
		self.acelerar(15000)
		}
		override method estaTranquila() = super() && not misilesDesplegados 
}

class Hospital inherits Pasajero {
	var tienePreparadosLosQuirofanos = false
	method prepararQuirofanos(){
		tienePreparadosLosQuirofanos = true
	}
	method desprepararQuirofanos(){
		tienePreparadosLosQuirofanos = false
	}
	override method estaTranquila() = super() && not tienePreparadosLosQuirofanos
	
}

class Sigilosa inherits Combate {
	override method estaTranquila() = super() && visible
}


