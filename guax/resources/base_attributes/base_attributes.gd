class_name BaseAttributes
extends Resource

@export_group("Stats")
@export var title: String
@export var maxHealth = 30
@export var attackspeed = 30
@export var speed = 30

@export_group("Attacks")
@export var base_attack: Attack
@export var special_attacks: Array[Attack]
