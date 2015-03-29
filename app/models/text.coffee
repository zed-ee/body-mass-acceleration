class Text extends Kinetic.Shape
	constructor: (text, options) ->
		@text = text or ''
		@options = options or {}
		Kinetic.Shape.call(this, @paint);
		
	paint: ->
		context = this.getContext();
		context.font = @options.font or "16pt Arial"
		context.textAlign = @options.textAlign or "center"
		context.textBaseline = @options.textBaseline or "middle"
		context.fillStyle = @options.fillStyle or "black" 
		context.fillText(@text, 0, 0);
		
module.exports = Text