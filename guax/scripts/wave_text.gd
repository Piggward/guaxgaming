class_name WaveText
extends Control

@onready var animation_player = $AnimationPlayer
@onready var wave_display = $WaveDisplay
@export var display_text: String
@export var text_type: TextType
@onready var wave_display_shadow = $WaveDisplayShadow
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var wave_display_2 = $WaveDisplay2

const GZ_WAVE_CLEAR = preload("res://sfx/gz_wave_clear.wav")
const WAVE_INTRO_DRUMS_GONG_SHORT = preload("res://sfx/wave_intro_drums_gong_short.wav")

var animation: String
var sound: AudioStream

enum TextType {WAVE_BEGIN, WAVE_CLEARED}

# Called when the node enters the scene tree for the first time.
func _ready():
	wave_display.text = display_text
	wave_display_shadow.text = display_text
	wave_display_2.text = display_text
	self.position.x -= wave_display.size.x / 2
	self.position.y -= wave_display.size.y / 2
	
	match text_type:
		TextType.WAVE_BEGIN: 
			animation = "new_animation"
			audio_stream_player_2d.stream = WAVE_INTRO_DRUMS_GONG_SHORT
		TextType.WAVE_CLEARED:
			animation = "wave_cleared"
			audio_stream_player_2d.stream = GZ_WAVE_CLEAR
	animation_player.play(animation)
	audio_stream_player_2d.play()
	await audio_stream_player_2d.finished
	if animation_player.is_playing():
		await animation_player.animation_finished
	self.queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	await get_tree().create_timer(1).timeout
	var x = 2
	pass
