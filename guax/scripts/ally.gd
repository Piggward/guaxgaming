class_name Ally
extends Npc

@export var cost: int
@export var upgrade: Upgrade
@export var promotion_path: Array[Promotion]

@onready var out_of_battle_state_machine = $OutOfBattleStateMachine

var upgrade_level = 0
var battle_start_location: Vector2

#In case someone needs to keep track on this exact Ally using reposition.
signal reposition(ally: Ally)
signal promoting(from: Ally, to: Ally)

func _ready():
	aggrozone = get_tree().get_nodes_in_group("Aggrozone")[0]
	out_of_battle_state_machine.init(self)
	TurnManager.battle_turn.turn_end.connect(refresh)
	super()
	
func refresh():
	global_position = battle_start_location
	set_health(maxHealth)

func promote(promotion: Promotion):
	if !promotion_path.any(func(p): return p == promotion):
		print_debug("promotion not possible")
		return
	var new_scene: Ally = promotion.promotion_scene.instantiate()
	new_scene.battle_start_location = battle_start_location
	promoting.emit(self, new_scene)
	GameManager.ally_promotion.emit(self, new_scene)
	
func basic_upgrade():
	if upgrade_level == 3:
		print_debug("only three upgrades allowed")
		return
	upgrade.apply(self)
	upgrade_level += 1
