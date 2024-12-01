class_name Upgrade
extends Resource

@export var cost: int
@export var bonus_health: int
@export var bonus_damage: int
@export var bonus_range: float
@export var bonus_attack_speed: float

func apply(ally: Ally):
	ally.maxHealth += bonus_health
	ally.attack.damage += bonus_damage
	ally.attack.range += bonus_range
	ally.attackspeed += bonus_attack_speed
