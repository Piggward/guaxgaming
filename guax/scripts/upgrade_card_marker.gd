extends Marker2D

const UPGRADE_CARD = preload("res://scenes/upgrade_card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.display_information_card.connect(display_upgrade_card)
	pass # Replace with function body.

func display_upgrade_card(ally: Ally):
	for child in get_children():
		# If upgrade_card is already displayed for this ally, we want to close the upgrade card.
		if child.ally == ally:
			child.queue_free()
			return
		child.queue_free()
	var upg = UPGRADE_CARD.instantiate()
	upg.ally = ally
	add_child(upg)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
