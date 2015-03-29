class Sign extends Kinetic.Shape
	constructor: (radius, number) ->
		@number = number or '70'
		@radius = radius or '60'
		@state = 0 	# 0 - not shown, 1 - sign shown, 2 - message shown, 3 - car shown
		
		Kinetic.Shape.call(this, @paint);
		
	paint: ->
		context = this.getContext();
		@circle(context, @radius, "red", 1, "black")
		@circle(context, @radius * 0.8 , "white", 1, "black")
 


		context.font = "bold " + Math.ceil(@radius* 0.80) + "pt Arial";
		context.textAlign = "center";
		context.textBaseline = "middle";
		context.fillStyle = "black";
		context.fillText(@number, 0, 0);
		
	circle: (context, radius, fillStyle, border, borderStyle) ->
		context.beginPath();
		context.arc(0, 0, radius, 0, 2 * Math.PI, false);
		context.fillStyle = fillStyle;
		context.fill();
		context.lineWidth = border;
		context.strokeStyle = borderStyle;
		context.stroke();
		
module.exports = Sign