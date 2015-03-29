class Arrow extends Kinetic.Shape
	constructor: (width, height) ->
		@width = width or 160;
		@height = height or 50;
		Kinetic.Shape.call(this, @paint);
		
	paint: ->
		context = this.getContext();
		
		context.strokeStyle = "#642403";
		context.lineWidth = 4;
		context.fillStyle = "#f7e2a1";
		context.beginPath();
		context.moveTo(- @width / 2, 0);
		context.lineTo(- @width / 2, -@height);
		context.lineTo(- @width, -@height);
		context.lineTo(0, -@height - (@width / 2));
		context.lineTo(@width, -@height);
		context.lineTo(@width / 2, -@height);
		context.lineTo(@width / 2, 0);
		context.closePath();
		context.fill();
		context.stroke();
		
module.exports = Arrow