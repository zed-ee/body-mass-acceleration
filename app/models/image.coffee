class ImageShape extends Kinetic.Shape
	constructor: (url) ->
		@image = new Image()
		@ready = false
		@image.onload = @imageLoaded
		if url
			@image.src = url
		Kinetic.Shape.call(this, @paint);
		
	imageLoaded: =>
		@ready = true
		if @getLayer()
			@getLayer().draw()
		
	paint: ->
		if @ready == true
			context = @getContext();
			context.drawImage(@image, 0, 0);
			# draw invisible detectable path for image
			context.beginPath();
			context.rect(0, 0, @image.width, @image.height)
			context.closePath();
			
module.exports = ImageShape
