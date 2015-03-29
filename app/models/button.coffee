class Button extends Kinetic.Shape
	constructor: (text, width, height) ->
		@width = width or 140
		@height = height or 40
		@text = text or "Submit"
		@enabled = true
		Kinetic.Shape.call(this, @paint);

	paint: ->
		context = this.getContext();
		context.fillStyle = "#009be2";
		context.lineWidth = 3;
		context.strokeStyle = "#642403";
		context.beginPath();
		context.rect(-@width / 2, -@height / 2, @width, @height)
		context.moveTo(0,0)

		context.closePath();	
		context.stroke();
		context.fill();
		context.font = "16pt Arial"
		context.textAlign = "center"
		context.textBaseline = "middle"
		context.fillStyle = "white"
		context.fillText(@text, 0, 0 );		

module.exports = Button
