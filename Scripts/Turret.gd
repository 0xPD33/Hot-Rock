extends KinematicBody2D

const MAX_DETECTION_RANGE = 600

onready var Player = get_node("/root/Level1/Player")
onready var AnimPlayer = get_parent().get_node("AnimationPlayer")
onready var MissileContainer = get_parent().get_node("MissileContainer")
onready var Missile = preload("res://Scenes/Missile.tscn")


func _process(delta):
	check_for_player()


func check_for_player():
	if $VisibilityNotifier2D.is_on_screen():
		AnimPlayer.play("rotate_turret")
		if has_line_of_sight():
			shoot_missile()
	else:
		pass


func shoot_missile():
	if $ShootRay.is_colliding():
		var collider = $ShootRay.get_collider()
		
		if collider is KinematicBody2D:
			var fired_missile = Missile.instance()
			MissileContainer.add_child(fired_missile)
			fired_missile.starting_pos(get_rotation(), get_position())


func has_line_of_sight():
	var space = get_world_2d().direct_space_state
	var LOS_obstacle = space.intersect_ray(global_position, Player.global_position, [self], collision_mask)
	
	var distance_to_player = Player.global_position.distance_to(global_position)
	var Player_in_range = distance_to_player < MAX_DETECTION_RANGE
	
	if LOS_obstacle.collider == Player and Player_in_range:
		return true
	else:
		return false

