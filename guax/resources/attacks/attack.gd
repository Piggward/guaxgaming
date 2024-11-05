class_name Attack
extends Resource

enum Type {MELEE, RANGED, PHYSICAL, MAGICAL}

@export var damage: int
@export var range: int
@export var types: Array[Type]
@export var animation: String
