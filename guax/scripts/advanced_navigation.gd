class_name AdvancedNavigation
extends NavigationAgent2D


@onready var npc: Npc = $".."
var avoidance_update_timer_bool = true
@export var avoid_update_time:float = 0.5
var steering_force:Vector2 = Vector2(0,0)

@onready var p0p1: RayCast2D = $"../Senses2d/01"
@onready var p1p1: RayCast2D = $"../Senses2d/11"
@onready var p1p0: RayCast2D = $"../Senses2d/10"
@onready var p1n1: RayCast2D = $"../Senses2d/1-1"
@onready var p0n1: RayCast2D = $"../Senses2d/0-1"
@onready var n1n1: RayCast2D = $"../Senses2d/-1-1"
@onready var n1p0: RayCast2D = $"../Senses2d/-10"
@onready var n1p1: RayCast2D = $"../Senses2d/-11"
#NAVIGATION
func _ready():	
	navigation_finished.connect(_on_nav_finished)
	velocity_computed.connect(_on_navigation_agent_2d_velocity_computed)

func calculate_velocity(target_position:Vector2):
	set_agent_target(target_position)
	
	
	#calculateNewVelocityTarget()
	var next_path_pos = get_next_path_position()
	var direction = npc.global_position.direction_to(next_path_pos).normalized()
	
	avoid_bool_timer()
	
	if(avoidance_update_timer_bool):
		steering_force = calculate_steering_force(next_path_pos)
	var new_velocity = ((direction+steering_force*4)).normalized() * npc.speed
	npc.velocity = new_velocity

	
func stand_still():
	velocity=Vector2.ZERO

func set_agent_target(target_position:Vector2):
	self.target_position = target_position

func _on_nav_finished():
	pass

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	pass
	
func calculate_steering_force(target_position:Vector2):
	avoidance_update_timer_bool = false
	var normalized_target_vector = (target_position - npc.global_position).normalized()
	var direction_array = [Vector2(0,1).normalized(),Vector2(1,1).normalized(),Vector2(1,0).normalized(),Vector2(1,-1).normalized(),Vector2(0,-1).normalized(),Vector2(-1,-1).normalized(),Vector2(-1,0).normalized(),Vector2(-1,1).normalized()]
	var intrest_array = [1,1,1,1,1,1,1,1]
	
	for i in intrest_array.size():
		intrest_array[i] = normalized_target_vector.dot(direction_array[i])
	
	var obstacle_array = [0,0,0,0,0,0,0,0]
	var ray_array = [p0p1,p1p1,p1p0,p1n1,p0n1,n1n1,n1p0,n1p1]
	var i = 0
	for ray in ray_array:
		if (ray.is_colliding()):
				obstacle_array[i] = 5
				if(i+1 == ray_array.size()):
					obstacle_array[i-1] = 5
					obstacle_array[0] = 5
				elif(i == 0):
					obstacle_array[i+1] = 5
					obstacle_array[ray_array.size()-1] = 5
				else:
					obstacle_array[i+1] = 5
					obstacle_array[i-1] = 5
		i +=1
	
	var context_array = intrest_array
	
	for ii in context_array.size():
		context_array[ii] = intrest_array[ii] - obstacle_array[ii]
		
	var correct_value = 0
	i = 0
	for context_value in context_array:
		if(context_value == context_array.max()):
			correct_value = i
		i +=1
	var steering_force_local = ((direction_array[correct_value])+npc.velocity.normalized()).normalized()
	return steering_force_local

func avoid_bool_timer():
	await get_tree().create_timer(1).timeout #avoid_update_time funkar ej här? hårdkodar 1
	avoidance_update_timer_bool = true
