extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	if text.contains("-"):
		text = text.replace("-", "")
		self.set("theme_override_colors/font_color", Color.GREEN)
	pass # Replace with function body.


func _process(delta):
	self.position.y -= 25 * delta
	modulate.a -= 0.4 * delta
	if modulate.a <= 0:
		self.queue_free()
	pass
