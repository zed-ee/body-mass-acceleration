class Line extends Kinetic.Shape
	constructor: (width, height) ->
		@width = width or 0;
		@height = height or 50;
		@state = 0
		Kinetic.Shape.call(this, @paint);
		
	paint: ->
		if @width < @height * 4
			return
		context = this.getContext();
		
		context.strokeStyle = "black";
		context.lineWidth = 4;
		context.fillStyle = "grey";
		context.beginPath();
		context.moveTo(0, 0);
		context.lineTo(@width, 0);
		
		context.lineTo(@width - @height * 4, -@height * 2);
		context.lineTo(@width - @height * 4, -@height);
		context.lineTo(0, -@height);
		context.closePath();
		context.fill();
		#context.stroke();
		
module.exports = Line