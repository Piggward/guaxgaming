class_name Level
extends Node2D

@export var player_starting_gold: int
@export var player_starting_health: int
@export var waves: Array[WaveResource]
@onready var enemy_spawn = $EnemySpawn
@onready var aggro_zone = $AggroZone
var current_wave = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.player_gold = player_starting_gold
	GameManager.player_max_health = player_starting_health
	GameManager.player_health = player_starting_health
	GameManager.level = self
	TurnManager.init()
	
	# Increment current wave on battle turn end.
	TurnManager.battle_turn.turn_end.connect(func(): current_wave += 1)
	pass # Replace with function body.

func spawn_next_wave():
	var wave = waves[current_wave - 1]
	for nmy in wave.enemies:
		if nmy is EnemySpawnLocation:
			var enemy = nmy.enemy.instantiate()
			enemy.position = nmy.spawn_location
			spawn_enemy(enemy)

func spawn_enemy(enemy: Enemy):
	enemy_spawn.spawn(enemy)
	
func spawn_soldier(ally: Ally):
	aggro_zone.add_child(ally)
	ally.global_position = ally.battle_start_location
	
func spawn_placeholder(placeholder: PlaceholderUnit):
	aggro_zone.add_child(placeholder)
	placeholder.global_position = to_local(placeholder.battle_position)
	
func get_current_enemies():
	var count = 0
	for child in enemy_spawn.get_children:
		if child is Npc:
			if child.isEnemy:
				count += 1
	return count

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
