extends Marker2D

const UPGRADE_CARD = preload("res://scenes/upgrade_card.tscn")
const ENEMY_CARD = preload("res://scenes/enemy_card.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.display_information_card.connect(display_card)
	pass # Replace with function body.


func display_card(npc: Npc):
	if npc is Ally:
		display_upgrade_card(npc)
	elif npc is Enemy:
		display_enemy_card(npc)
		
func display_upgrade_card(ally: Ally):
	for child in get_children():
		# If upgrade_card is already displayed for this ally, we want to close the upgrade card.
		if child is UpgradeCard and child.ally == ally:
			child.queue_free()
			return
		child.queue_free()
	var upg = UPGRADE_CARD.instantiate()
	upg.ally = ally
	add_child(upg)
	
func display_enemy_card(enemy: Enemy):
	for child in get_children():
		# If upgrade_card is already displayed for this ally, we want to close the upgrade card.
		if child is EnemyCard and child.enemy == enemy:
			child.queue_free()
			return
		child.queue_free()
	var card = ENEMY_CARD.instantiate()
	card.enemy = enemy
	add_child(card)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
