extends RigidBody2D

@onready var navigation_agent_2d = $NavigationAgent2D

# Called when the node enters the scene tree for the first time.
func _ready():
	navigation_agent_2d.target_position = Vector2(0, 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print_debug(navigation_agent_2d.get_next_path_position())
	position = navigation_agent_2d.get_next_path_position()
	pass
