extends AudioStreamPlayer

@onready var music: AudioStreamPlaybackInteractive = self.get_stream_playback()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("left_mouse"):
		music.switch_to_clip_by_name(&"transition")
	pass
