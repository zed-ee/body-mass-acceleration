class Star extends Kinetic.Shape
	constructor: ->
		Kinetic.Shape.call(this, @paint);
		
	paint: ->
		context = this.getContext();
		starRadius = 80;
		context.strokeStyle = "black";
		context.lineWidth = 2;
		context.fillStyle = "#b5ff88";
		context.beginPath();
		context.moveTo(0, starRadius);

		for n in [0..9]
			radius = if n % 2 == 0 then starRadius else starRadius * this.starRadiusInnerCoef
			x = radius * Math.sin(n * 2 * Math.PI / 10);
			y = radius * Math.cos(n * 2 * Math.PI / 10);
			context.lineTo(x, y);


		context.closePath();
		context.fill();
		context.stroke();
		
module.exports = Star