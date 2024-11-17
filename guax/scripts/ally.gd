class_name Ally
extends Npc

var battle_start_location: Vector2
@export var cost: int
@onready var out_of_battle_state_machine = $OutOfBattleStateMachine
@export var ally_class: Class
var upgrade_level = 0

signal reposition(ally: Ally)
#In case someone needs to keep track on this exakt Ally.
signal class_upgrading(from: Ally, to: Ally)

func _ready():
	aggrozone = get_tree().get_nodes_in_group("Aggrozone")[0]
	out_of_battle_state_machine.init(self)
	TurnManager.battle_turn.turn_end.connect(refresh)
	super()
	
func refresh():
	global_position = battle_start_location
	set_health(maxHealth)

func class_upgrade(upgrade_class: Class):
	var upgrade: Ally = ally_class.class_upgrades.filter(func(c): return c == upgrade_class)[0].get_class_upgrade_instance()
	upgrade.battle_start_location = battle_start_location
	class_upgrading.emit(self, upgrade)
	GameManager.ally_class_upgraded.emit(self, upgrade)
	
func basic_upgrade():
	if upgrade_level == 3:
		print_debug("only three upgrades allowed")
		return
	ally_class.upgrade.apply(self)
	upgrade_level += 1
