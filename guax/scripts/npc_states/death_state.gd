class_name DeathState
extends NpcState


func act():
	# Do nothing
	pass

func enter():
	# TODO: play death animation
	#npc.play_animation(npc.title+"/Death")
	
	# Stop npc from moving when dead
	npc.velocity = Vector2.ZERO

func exit():
	pass
