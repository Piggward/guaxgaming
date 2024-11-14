extends AnimationPlayer

func _ready():
	pass
	#animation_finished.connect(on_animation_finished) 

func play_animation(animation: String):
	play(animation)

#func on_animation_finished("Attack1"):
	#pass
	#play("Idle")
