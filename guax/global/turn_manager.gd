extends Node

var shop_turn: ShopTurnPhase
var battle_turn: BattleTurnPhase
var current_phase: TurnPhase
var is_ready = false

func _ready():
	shop_turn = ShopTurnPhase.new()
	battle_turn = BattleTurnPhase.new()
	shop_turn.phase = TurnPhase.Phase.SHOPPING
	battle_turn.phase = TurnPhase.Phase.BATTLE
	current_phase = shop_turn

func init():
	current_phase = shop_turn
	is_ready = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_ready:
		return
		
	current_phase.phase_act()
	pass

func next_turn():
	match(current_phase):
		ShopTurnPhase: current_phase = battle_turn
		BattleTurnPhase: current_phase = shop_turn
	current_phase.phase_start()
