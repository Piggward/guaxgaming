class_name DamageZone
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Enemy:
		body.queue_free()
		GameManager.player_take_damage(body.attack_manager.base_attack.damage)
	pass # Replace with function body.
