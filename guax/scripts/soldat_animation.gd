extends Node


@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

func _ready():
	animation_player.animation_finished.connect(on_animation_finished) 

func play_idle():
	animation_player.play("Idle")

func play_attack():
	animation_player.play("Attack_melee_1")

func on_animation_finished():
	animation_player.play("Idle")
