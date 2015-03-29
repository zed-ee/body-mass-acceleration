class Slider extends Kinetic.Shape
	constructor: (width, height) ->
		@width = 260
		@height = height or 50
		@carretWidth = 6
		@carretHeight = 20
		@carretPos = 0
		@enabled = true
		@text = ""
		Kinetic.Shape.call(this, @paint);

	paint: ->
		shift = @carretPos * @width
		context = this.getContext();
		context.beginPath();
		context.lineWidth = 10;
		context.strokeStyle = "#009be2";
		context.moveTo(0, -@carretHeight /2);
		context.lineTo(@width, -@carretHeight /2);
		context.closePath();
		context.stroke();
		
		context.strokeStyle = "#642403";
		context.lineWidth = 2;
		context.fillStyle = "#009be2";
		context.beginPath();
		context.moveTo(- @carretWidth + shift, 0);
		context.lineTo(- @carretWidth + shift, -@carretHeight);
		context.lineTo(shift, -@carretHeight - (@carretWidth / 2));
		context.lineTo(@carretWidth + shift, -@carretHeight);
		context.lineTo(@carretWidth + shift, 0);
		context.closePath();
		context.fill();
		context.stroke();
		
		context = this.getContext();
		context.font = "16pt Arial"
		context.textAlign = "center"
		#context.textBaseline = @options.textBaseline
		context.fillStyle = "black"
		context.fillText(@text, shift, -@carretHeight * 1.5 );		
		# draw invisible detectable path for image
		context.beginPath();
		context.rect(0, 0, @width, -@carretHeight * 1.5)
		context.closePath();		
module.exports = Slider