class_name Level
extends Node2D

@export var player_starting_gold: int
@export var player_starting_health: int
@export var waves: Array[PackedScene]
@onready var enemy_spawn = $EnemySpawn
@onready var aggro_zone = $AggroZone
var current_wave = 1
const WAVE_TEXT = preload("res://scenes/wave_text.tscn")
@onready var canvas_layer = $CanvasLayer


#save current gold reward
var current_wave_gold_reward

# Called when the node enters the scene tree for the first time.
func _ready():
	TurnManager.battle_turn.turn_end.connect(_on_battle_turn_end)
	TurnManager.battle_turn.turn_start.connect(_on_battle_turn_start)
	TurnManager.shop_turn.turn_start.connect(_on_shop_turn_start)
	
	GameManager.player_gold = player_starting_gold
	GameManager.player_max_health = player_starting_health
	GameManager.player_health = player_starting_health
	GameManager.player_gold_updated.emit(player_starting_gold)
	GameManager.level = self
	
	TurnManager.init()
	pass # Replace with function body.

func display_wave_text(text: String, type: WaveText.TextType):
	var wave_text = WAVE_TEXT.instantiate()
	wave_text.display_text = text
	wave_text.text_type = type
	wave_text.position += Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
	canvas_layer.add_child(wave_text)
	
func _on_shop_turn_start():
	var wave = waves[current_wave - 1].instantiate()
	for child in wave.get_children():
		if child is Enemy:
			enemy_spawn.spawn_enemy(child)
		if child is gold_reward:
			current_wave_gold_reward = child.gold_rewarded
func _on_battle_turn_end():
	if current_wave == waves.size(): 
		GameManager.game_won()
		return
	var text = "WAVE " + str(current_wave)
	display_wave_text(text, WaveText.TextType.WAVE_CLEARED)
	current_wave += 1
	#Reward gold from wave reward and income
	GameManager.transaction(-current_wave_gold_reward)
	GameManager.transaction(-GameManager.player_income)
	
func _on_battle_turn_start():
	var text = "WAVE " + str(current_wave)
	display_wave_text(text, WaveText.TextType.WAVE_BEGIN)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
