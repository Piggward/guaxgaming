class_name Class
extends Resource

@export var cost: int
@export var upgrade: Upgrade
@export var class_upgrades: Array[Class]
@export var class_scene_path: String


func get_class_upgrade_instance() -> Ally:
	var class_scene = load("res://scenes/allies/" + class_scene_path + ".tscn")
	return class_scene.instantiate()
