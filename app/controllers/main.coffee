Spine = require('spine')
Star = require('models/star')
Arrow = require('models/arrow')
Sign = require('models/sign')
Box = require('models/box')
Line = require('models/line')
Text = require('models/text')
ImageShape = require('models/image')
Slider = require('models/slider')
Button = require('models/button')

class Main extends Spine.Controller
	elements:
		'#canvas': 'canvas'
		'#weightx': 'weightEl'
		'#weight_display': 'displayEl'
		'.control': 'controlEl'
	events: 
		'click input[type=submit]': 'run'
		'change #weightx': 'updatex'

		
	_w = 1024
	_h = 600
	


	constructor: (params) ->
		@log params.data
		super
		Main.cars = params.data.cars
		Main.languages = params.data.languages
		Main.messages = params.data.messages
		@log @cars, @languages, @messages
		@lang = 'ee'
		@state = 0
		@speed = 30
		@weight = 10
		# Render initial view
		#@html require('views/main')()
		wr = $(document).width()
		h = $(document).height()
		w =  Math.min(1000, wr)
		@cw = w
		@ch = h
		rx =  w / _w
		ry = h / _h
		if rx > ry
			@cw = ry * _w
			@ch = ry * _h
			@scale = ry
		else
			@cw = rx * _w
			@ch = rx * _h
			@scale = rx
		
		leftShift = (wr - @cw) / 2
		@el.css({'left': leftShift + 'px', 'width': @cw + 'px', 'height': @ch + 'px'})
		@controlEl.css({'left': (500*@scale) + 'px'})
		@log "Main.init", @el, [w, h], [@cw, @ch], [rx, ry], @scale, leftShift
		
		@stage = new Kinetic.Stage("canvas", @cw, @ch);
#		@stage = new Kinetic.Stage({container: "canvas", width: @cw, height: @ch });
		@stage.setScale(@scale, @scale);
		@backgroundLayer = new Kinetic.Layer();
		@animatedLayer = new Kinetic.Layer();
		@starRadiusInnerCoef = 0.5;
		@initObjects()
		@placeObjects()
		@updatex()
		
		@log "languages: ", Main.languages
		_this = @
		for lang in Main.languages
			@log "lang: ", lang		
			lang.shape = new ImageShape('flags/png/'+lang.code+'.png')
			lang.shape.setScale(2)
			lang.shape.code = lang.code
			lang.shape.setPosition(@cw *9 / 10 - lang.index * 50 * @scale, @ch * 1 / 30);
			lang.shape.on "mousedown touchstart", (x) ->
				_this.log  "lang.mousedown", @
				_this.lang = @code
				_this.updateTexts()
				
			lang.shape.on "mouseover", (x) ->
				document.body.style.cursor = "pointer"
			lang.shape.on "mouseout", (x) ->
				document.body.style.cursor = "default"
			
			@animatedLayer.add(lang.shape, lang.code)
			
		@updatex()
		@updateTexts()
		
		$("body").bind("mouseup", @dragEnd).bind("mousemove touchmove", @dragMove)
		
	restart: ->
		@log "restart"
		@state = 0
		@backgroundLayer.add(@welcome)
		@backgroundLayer.add(@info)
		@sign1.state = 0
		@sign2.state = 0
		@sign3.state = 0
		
		@line1.state = 0
		@line2.state = 0
		@line3.state = 0
		
		@line1.width = 0
		@line2.width = 0
		@line3.width = 0
		@arrow.height = 10
		@cars = []
		
		@txtCurrentSpeed.text ="";
		@txtCalculatedMass.text ="";
		@button.text = Main.messages[@lang].arvuta
		@slider.enabled = true
		@backgroundLayer.draw()

		try 
			@animatedLayer.remove(@eq1)
			@animatedLayer.remove(@eq2)
			@animatedLayer.remove(@eq3)

			@animatedLayer.remove(@sign1)
			@animatedLayer.remove(@sign2)
			@animatedLayer.remove(@sign3)

			@animatedLayer.remove(@message1)
			@animatedLayer.remove(@message2)
			@animatedLayer.remove(@message3)

			@animatedLayer.remove(@message1sub)
			@animatedLayer.remove(@message2sub)
			@animatedLayer.remove(@message3sub)

			@animatedLayer.remove(@car1)
			@animatedLayer.remove(@car2)
			@animatedLayer.remove(@car3)

			@animatedLayer.remove(@car1text)
			@animatedLayer.remove(@car2text)
			@animatedLayer.remove(@car3text)
					
			@animatedLayer.remove(@car1info)
			@animatedLayer.remove(@car2info)
			@animatedLayer.remove(@car3info)
			
	
		catch error
			@log error	

		@animatedLayer.draw()
		
	run: ->
		$("#galleries a").fancybox();
	
		#@weight = parseInt(@weightEl.val())
		@log "Run: ", @weightEl, @weight

		date = new Date();
		time = date.getTime();
		@speed = 30
		#@weight = 75

		@backgroundLayer.remove(@welcome)
		@backgroundLayer.remove(@info)
		@backgroundLayer.draw()

			
		carWeight1 = @calcMass(50)
		carWeight2 = @calcMass(70)
		carWeight3 = @calcMass(90)
		@log "carWeight", carWeight1, carWeight2, carWeight3
		found1 = false
		found2 = false
		found3 = false
		for x in Main.cars
			if not found1 and x.weight > carWeight1
				@car1.image.src = x.pic
				@car1text.text = x.texts[@lang]
				@car1url = x.url
				found1 = true
			if not found2 and  x.weight > carWeight2
				@car2.image.src = x.pic
				@car2text.text = x.texts[@lang]
				@car2url = x.url
				found2 = true
			if not found3 and x.weight > carWeight3
				@car3.image.src = x.pic
				@car3text.text = x.texts[@lang]
				@car3url = x.url
				found3 = true

		@animate(time)
		
	updatex: ->
		@slider.text = @weight + Main.messages[@lang].kg
		@log "updatex", @weight,  Main.messages[@lang].kg, @slider.text
		@slider.carretPos = ( @weight - 10) / 180
		@backgroundLayer.draw()
		
	updateTexts: ->
		@log "updateTexts: ", Main.messages, @lang
		@lblSinuKaal.text = Main.messages[@lang].sinu_kaal
		@button.text = if @state == 0 then Main.messages[@lang].arvuta else Main.messages[@lang].algusesse
		@slider.text = @weight + Main.messages[@lang].kg
		@welcome.text = Main.messages[@lang].welcome
		@info.text = Main.messages[@lang].info
		@message1.text = Main.messages[@lang].teade + '50km/h'
		@message2.text = Main.messages[@lang].teade + '70km/h'
		@message3.text = Main.messages[@lang].teade + '90km/h'
		@backgroundLayer.draw()
		@animatedLayer.draw()
		
	initObjects: ->
		#@bg = new Box(_w, _h)
		@star = new Star
		@arrow = new Arrow(100, 10)
		@sign1 = new Sign(40, '50')
		@sign2 = new Sign(40, '70')
		@sign3 = new Sign(40, '90')
		@line1 = new Line(0, 10)
		@line2 = new Line(0, 10)
		@line3 = new Line(0, 10)
		
		@logo = new ImageShape('images/mm_logo.png')
		@bg = new ImageShape('images/bg.jpg')
		
		@txtCurrentSpeed = new Text()
		@txtCalculatedMass = new Text()
		@lblSinuKaal = new Text( )
		@slider = new Slider()
		@button = new Button("Arvuta")

		@message1 = new Text("Sinu kaal kiirusel", { font: "16pt Arial", textAlign: 'left', fillStyle: "#888888"})
		@message2 = new Text("Sinu kaal kiirusel", { font: "16pt Arial", textAlign: 'left', fillStyle: "#888888"})
		@message3 = new Text("Sinu kaal kiirusel 50 km/h", { font: "16pt Arial", textAlign: 'left', fillStyle: "#888888"})
		
		@message1sub = new Text("2000 kg", { font: "17pt Arial", textAlign: 'left', fillStyle: "#a7390d"})
		@message2sub = new Text("2000 kg", { font: "17pt Arial", textAlign: 'left', fillStyle: "#a7390d"})
		@message3sub = new Text("2000 kg", { font: "17pt Arial", textAlign: 'left', fillStyle: "#a7390d"})
		
		@eq1 = new Text("=", { font: "68pt Arial", textAlign: 'left', fillStyle: "#aaaaaa"})
		@eq2 = new Text("=", { font: "68pt Arial", textAlign: 'left', fillStyle: "#aaaaaa"})
		@eq3 = new Text("=", { font: "68pt Arial", textAlign: 'left', fillStyle: "#aaaaaa"})
		
		@car1 = new ImageShape('images/cars/taksikoer.jpg')
		@car2 = new ImageShape()
		@car3 = new ImageShape()
		
		@car1text = new Text("", { font: "11pt Arial", fillStyle: "#a7390d", textAlign: 'right'})
		@car2text = new Text("", { font: "11pt Arial", fillStyle: "#a7390d", textAlign: 'right'})
		@car3text = new Text("", { font: "11pt Arial", fillStyle: "#a7390d", textAlign: 'right'})

		@car1info = new ImageShape('images/info_small.png')
		@car2info = new ImageShape('images/info_small.png')
		@car3info = new ImageShape('images/info_small.png')

				
		@welcome = new Text(Main.messages[@lang].welcome, { font: "28pt Arial", fillStyle: "#009be2"})
		@info = new Text(Main.messages[@lang].info, { font: "16pt Arial", fillStyle: "#a7390d"})
		_this = @
		
		@slider.on "mousedown touchstart", @dragStart	
				
		#@slider.on "mousemove touchmove", @dragMove
			
		#@slider.on "mouseup touchend", @dragEnd
			
		@slider.on "mouseover", (x) ->
			if @enabled
				document.body.style.cursor = "pointer"
				
		@slider.on "mouseout", (x) ->
			#@drag = false
			document.body.style.cursor = "default"		

		@button.on "click touchstart", (x) ->
			if @enabled
				if _this.state == 0 
					@enabled = false
					_this.slider.enabled = false
					_this.run(this, x)
				else
					_this.restart()
					
		@button.on "mouseover", (x) ->
			document.body.style.cursor = "pointer"
		@button.on "mouseout", (x) ->
			document.body.style.cursor = "default"					
			
			
		@car1info.on "mousedown touchstart", (x) =>
			@log "car1info", @car1url, @car1text.text
			$("a[rel="+@car1url+"]:first").click()
			$("a[rel="+@car1url+"]").attr("title", @car1text.text)
			
		@car2info.on "mousedown touchstart", (x) =>
			@log "car2info", @car2url, @car2text.text
			$("a[rel="+@car2url+"]:first").click()
			
		@car3info.on "mousedown touchstart", (x) =>
			@log "car3info", @car3url, @car3text.text
			#$.fancybox({href: "#taksikoer"})
			$("a[rel="+@car3url+"]:first").click()
			
		@car1info.on "mouseover", (x) ->
			document.body.style.cursor = "pointer"
		@car1info.on "mouseout", (x) ->
			document.body.style.cursor = "default"
		@car2info.on "mouseover", (x) ->
			document.body.style.cursor = "pointer"
		@car2info.on "mouseout", (x) ->
			document.body.style.cursor = "default"
		@car3info.on "mouseover", (x) ->
			document.body.style.cursor = "pointer"
		@car3info.on "mouseout", (x) ->
			document.body.style.cursor = "default"		

		@logo.on "mouseover", (x) ->
			document.body.style.cursor = "pointer"
		@logo.on "mouseout", (x) ->
			document.body.style.cursor = "default"		
		@logo.on "mousedown touchstart", (x) =>
			@log "logo.click"
			$('#logo').click()

			
	dragStart: (x) =>
		@log  "dragStart", @state, x
		if @slider.enabled
			@slider.drag = true
			@moveCarret(x)
		else 
			if @state == 1 
				@restart()	
				@dragStart(x)
				
	dragMove: (x) =>
		if @slider.enabled and @slider.drag == true
			@moveCarret(x)
	
	dragEnd: (x) =>
		@slider.drag = false
	
	moveCarret: (mouse) ->
	    #@log mouse.clientX, $(mouse.target).offset().left
		mouse_x = mouse.layerX or mouse.offsetX or (mouse.clientX - $(mouse.target).offset().left)
		@log "moveCarret", mouse, mouse_x, @slider.getPosition()
		if (!mouse_x)
			return
		pos = (mouse_x - @slider.getPosition().x) / @slider.width / @scale
		@weight = Math.ceil(pos * 180 + 10)
		@weight = Math.max(10, @weight)
		@weight = Math.min(180, @weight)
		#@log "drag event: ", mouse
		@log(mouse_x, @slider.getPosition().x, @slider.width, pos)
		@updatex()

	placeObjects: ->
		@log "placeObjects", @speedFunc(50), @speedFunc(70), @speedFunc(90)
		#@log "placeObjects",  - @speedFunc(50), @ch - @speedFunc(70), @ch - @speedFunc(90)
		@star.setPosition(@cw / 2, @ch / 2)
		#@star.setScale(@scale, @scale);
		@logo.setPosition(@cw / 2 - 60, @ch * 1 / 30);
		@welcome.setPosition(@cw / 2, @ch / 2);
		@info.setPosition(@cw / 2, @ch / 2.4);
		@arrow.setPosition(@cw / 8, @ch);
		@sign1.setPosition(@cw / 8, @ch - @speedFunc(50) * @scale) ;
		@sign2.setPosition(@cw / 8, @ch - @speedFunc(70) * @scale);
		@sign3.setPosition(@cw / 8, @ch - @speedFunc(90) * @scale);

		@line1.setPosition(@cw / 8 + 60 * @scale, @ch - (@speedFunc(50) - 40) * @scale) ;
		@line2.setPosition(@cw / 8 + 60 * @scale, @ch - (@speedFunc(70) - 40) * @scale);
		@line3.setPosition(@cw / 8 + 60 * @scale, @ch - (@speedFunc(90) - 40) * @scale);

		@message1.setPosition(@cw / 8 + 100 * @scale, @ch - (@speedFunc(50) + 20) * @scale) ;
		@message2.setPosition(@cw / 8 + 100 * @scale, @ch - (@speedFunc(70) + 20) * @scale);
		@message3.setPosition(@cw / 8 + 100 * @scale, @ch - (@speedFunc(90) + 20) * @scale);
		
		@message1sub.setPosition(@cw / 8 + 240 * @scale, @ch - (@speedFunc(50) - 10) * @scale) ;
		@message2sub.setPosition(@cw / 8 + 240 * @scale, @ch - (@speedFunc(70) - 10) * @scale);
		@message3sub.setPosition(@cw / 8 + 240 * @scale, @ch - (@speedFunc(90) - 10) * @scale);
		
		@eq1.setPosition(@cw * 3 / 4 - 100 *@scale, @ch - (@speedFunc(50) - 0) * @scale) ;
		@eq2.setPosition(@cw * 3 / 4 - 100 *@scale, @ch - (@speedFunc(70) - 0) * @scale) ;
		@eq3.setPosition(@cw * 3 / 4 - 100 *@scale, @ch - (@speedFunc(90) - 0) * @scale) ;
		
		@txtCurrentSpeed.setPosition(@cw / 8 - 80 * @scale, @ch);
		@txtCalculatedMass.setPosition(@cw / 8 - 80 * @scale, @ch);

		@lblSinuKaal.setPosition(@cw / 3, @ch - 32 * @scale);
		@slider.setPosition(@cw / 3 + 80 * @scale, @ch - 20 * @scale);

		@button.setPosition(@cw * 2 / 3 + 100 * @scale, @ch - 32 * @scale);
		
		@car1.setPosition(@cw *3 / 4 + (40 *@scale), @ch - (@speedFunc(50) + 90) * @scale)
		@car2.setPosition(@cw *3 / 4 + (40 *@scale), @ch - (@speedFunc(70) + 90) * @scale)
		@car3.setPosition(@cw *3 / 4 + (40 *@scale), @ch - (@speedFunc(90) + 90) * @scale)
		
		@car1text.setPosition(@cw - (60 *@scale), @ch - (@speedFunc(50)-35) * @scale)
		@car2text.setPosition(@cw - (60 *@scale), @ch - (@speedFunc(70)-35) * @scale)
		@car3text.setPosition(@cw - (60 *@scale), @ch - (@speedFunc(90)-35) * @scale)

		@car1info.setPosition(@cw - (50 *@scale), @ch - (@speedFunc(50)-25) * @scale)
		@car2info.setPosition(@cw - (50 *@scale), @ch - (@speedFunc(70)-25) * @scale)
		@car3info.setPosition(@cw - (50 *@scale), @ch - (@speedFunc(90)-25) * @scale)
		
		
		@backgroundLayer.add(@bg);
		@backgroundLayer.add(@logo);
		@backgroundLayer.add(@welcome);
		@backgroundLayer.add(@info);
		@backgroundLayer.add(@lblSinuKaal);
		@backgroundLayer.add(@button);
#		@backgroundLayer.add(@eq);

		@backgroundLayer.add(@slider)
		@animatedLayer.add(@line1)
		@animatedLayer.add(@line2)
		@animatedLayer.add(@line3)

#		@animatedLayer.add(@message1)
#		@animatedLayer.add(@message2)
#		@animatedLayer.add(@message3)
		
#		@animatedLayer.add(@message1sub)
#		@animatedLayer.add(@message2sub)
#		@animatedLayer.add(@message3sub)
		
#		@animatedLayer.add(@car1)
#		@animatedLayer.add(@car2)
#		@animatedLayer.add(@car3)

#		@animatedLayer.add(@car1)
#		@animatedLayer.add(@car1info)
#		@animatedLayer.add(@car1text)


		#@animatedLayer.add(@star);
		@animatedLayer.add(@arrow);
		@animatedLayer.add(@txtCurrentSpeed)
		@animatedLayer.add(@txtCalculatedMass)
		
		@stage.add(@backgroundLayer);
		@stage.add(@animatedLayer);

		#@run()
		
	animate: (lastTime) ->
		date = new Date()
		time = date.getTime()
		timeDiff = time - lastTime
		@star.angularVelocity = 2
		@star.rotate(timeDiff * @star.angularVelocity / 1000);
		amplitude = 0.5;
		period = 4000; # in ms
		centerX = 0.5
#		@log "1", @ststarRadiusInnerCoef
		@starRadiusInnerCoef = amplitude * Math.sin(time * 2 * Math.PI / period) + centerX;
		@star.starRadiusInnerCoef = @starRadiusInnerCoef
#		@log "2", @star.starRadiusInnerCoef
		# draw
		@speed += timeDiff * 0.01;
		#@log "speed: ", timeDiff, @speed, @speedFunc(@speed)
		if @sign3.state == 0
			@arrow.height = @speedFunc(@speed) + 55
			if @sign1.state == 0 and @speed > 49
				@animatedLayer.add(@sign1)
				@sign1.state = 1
				@animate1(50, @line1, @message1, @message1sub, @eq1, @car1, @car1text, @car1info, time)
				return
				
			if @sign2.state == 0 and  @speed > 69
				@animatedLayer.add(@sign2);
				@sign2.state = 1
				@animate1(70, @line2, @message2, @message2sub, @eq2, @car2, @car2text, @car2info, time)
				return
				
			if @sign3.state == 0 and  @speed > 89
				@animatedLayer.add(@sign3);
				@sign3.state = 1
				@animate1(90, @line3, @message3, @message3sub, @eq3, @car3, @car3text, @car3info, time)
				return
		
			@txtCurrentSpeed.setPosition(@cw / 8, @ch - (@speedFunc(@speed) + 20) * @scale);
			@txtCalculatedMass.setPosition(@cw / 8, @ch - (@speedFunc(@speed)- 6) * @scale);
			@txtCurrentSpeed.text = Math.ceil(@speed) + "km/h"
			@txtCalculatedMass.text = Math.ceil(@calcMass(@speed)) + Main.messages[@lang].kg
			@animatedLayer.draw()
			requestAnimFrame =>
				@animate(time)

		else
			setTimeout @endAnimation, 500
			@backgroundLayer.draw()
			@animatedLayer.draw()
			
	endAnimation: =>
		@animatedLayer.add(@car1info)
		@animatedLayer.add(@car2info)
		@animatedLayer.add(@car3info)
		
		@button.enabled = true
		@button.text = Main.messages[@lang].algusesse
		@state = 1
		@slider.enabled = false
		@backgroundLayer.draw()
		@animatedLayer.draw()
				
	animate1: (speed, line, message, messagesub, eq, car, text, info, lastTime) ->
		date = new Date()
		time = date.getTime()
		timeDiff = time - lastTime
		if line.state == 0 and line.width > 100 
			message.speed = Math.ceil(@speed)
			message.text = Main.messages[@lang].teade + Math.ceil(speed) + 'km/h'
			@animatedLayer.add(message)
			message.moveToBottom()
			line.state = 1
			
		if line.state == 1 and line.width > 200 
			message.weight = Math.ceil(@calcMass(speed))
			messagesub.text = Math.ceil(@calcMass(speed)) + Main.messages[@lang].kg
			@animatedLayer.add(messagesub)
			messagesub.moveToBottom()
			line.state = 2
			
		if line.state == 2 and line.width > 350 
			@animatedLayer.add(eq)
			eq.moveToBottom()
			line.state = 3
			
		if line.width < 600
			line.width += timeDiff * 0.3
			@animatedLayer.draw()
			requestAnimFrame =>
				@animate1(speed, line, message, messagesub, eq, car, text, info, time)			
		else
			@animatedLayer.add(car)
			@animatedLayer.add(text)
			#car.moveToBottom()
			
			requestAnimFrame =>
				@animate(time)	

	speedFunc: (speed, maxHeight) ->
		p = ((speed - 30 ) / 70 ) * (_h - 55)
		
	calcMass: (speed) ->
		_speed = speed / 3.6
		(1 / (0.023 / _speed)  * (@weight / 9.8 ))
	
	myLog: (val) ->
		Math.log(val)# / Math.log(10)

module.exports = Main