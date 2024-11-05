class_name WaveText
extends Control

@onready var animation_player = $AnimationPlayer
@onready var wave_display = $WaveDisplay

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play()
	animation_player.animation_finished.connect(func(): self.queue_free())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
