class Box extends Kinetic.Shape
	constructor: (width, height, style) ->
		@width = width or 100
		@height = height or 100
		@style = style or "white"
		
		Kinetic.Shape.call(this, @paint);
		
	paint: ->
		context = @getContext();
		context.beginPath();
		context.rect(0, 0, @width, @height);
		context.fillStyle = @style;
		context.fill();
		
module.exports = Box