extends KinematicBody2D

var on_target = false
var held = false

var gravity : float = 600.0
var velocity = Vector2()

signal death


func _physics_process(delta: float):
	_calculate_position(delta)


func _calculate_position(delta):
	_on_hold()
	
	if held == false:
		velocity.y += gravity * delta
	
		var collision = move_and_collide(velocity * delta)
		
		#if collision:
		#	player_death()
	
	elif held == true:
		velocity.y = 0
		
		var collision = move_and_collide(velocity * delta)
		
		#if collision:
		#	player_death()
	
	if position.y > 800:
		player_death()


func _on_hold():
	if on_target and Input.is_action_pressed("hold_click"):
		held = true
	
	if held and Input.is_action_pressed("hold_click"):
		var pos = get_global_mouse_position()
		set_position(pos)
		rotation_degrees += 3
	else:
		held = false


func player_death():
	emit_signal("death")


func _on_Player_mouse_entered():
	on_target = true


func _on_Player_mouse_exited():
	on_target = false

