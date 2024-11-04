extends Node

var shop_turn: ShopTurnPhase
var battle_turn: BattleTurnPhase
var current_phase: TurnPhase
var is_ready = false

signal end_phase_requested()

func _ready():
	shop_turn = ShopTurnPhase.new()
	battle_turn = BattleTurnPhase.new()
	shop_turn.phase = TurnPhase.Phase.SHOPPING
	battle_turn.phase = TurnPhase.Phase.BATTLE
	current_phase = shop_turn
	end_phase_requested.connect(_on_end_turn_requested)

func init():
	current_phase.phase_start()
	is_ready = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_ready:
		return
		
	current_phase.phase_act()
	pass

func next_turn():
	match(current_phase.phase):
		TurnPhase.Phase.SHOPPING: current_phase = battle_turn
		TurnPhase.Phase.BATTLE: current_phase = shop_turn
	current_phase.phase_start()
	
func _on_end_turn_requested():
	current_phase.phase_end()
