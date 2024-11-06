class_name WaveText
extends Control

@onready var animation_player = $AnimationPlayer
@onready var wave_display = $WaveDisplay
@export var display_text: String
@onready var wave_display_shadow = $WaveDisplayShadow

# Called when the node enters the scene tree for the first time.
func _ready():
	wave_display.text = display_text
	wave_display_shadow.text = display_text
	self.position.x -= wave_display.size.x / 2
	self.position.y -= wave_display.size.y / 2
	animation_player.play("new_animation")
	animation_player.animation_finished.connect(func(): self.queue_free())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
