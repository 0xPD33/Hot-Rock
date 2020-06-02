extends KinematicBody2D

var on_target : bool = false
var held : bool = false

var gravity : float = 600.0
var velocity = Vector2()

onready var Explosion = preload("res://Scenes/Explosion.tscn")

# get parent level, should be scalable
onready var Level = get_parent()

signal death


func _physics_process(delta: float):
	_calculate_position(delta)


func _calculate_position(delta):
	_on_hold()
	
	if held == false:
		velocity.y += gravity * delta
	
		var collision = move_and_collide(velocity * delta)
		
		if collision and Level.running == true:
			player_death()
	
	elif held == true:
		velocity.y = 0
		
		var collision = move_and_collide(velocity * delta)
		
		if collision and Level.running == true:
			player_death()
	
	if position.y > 800:
		player_death()


func _on_hold():
	# set held to true if mouse is on target and left mouse button is being held
	if on_target and Input.is_action_pressed("hold_click"):
		held = true
	
	# check if held is true and mouse button is still being pressed and set the position of the player
	# to the mouse position. also rotate!
	if held and Input.is_action_pressed("hold_click"):
		var pos = get_global_mouse_position()
		set_position(pos)
		rotation_degrees += 3
	else:
		held = false


func explode(hit_loc, colliding_obj):
	# create a new instance of the explosion effect and set it up correctly
	var expl = Explosion.instance()
	
	# add explosion as a child to the parent level
	Level.add_child(expl)
	
	# set position to the hitlocation and play the animation
	expl.set_position(hit_loc)
	expl.play()


func player_death():
	var dead : bool = true
	
	explode(get_position(), self)
	
	# emit signal death to Game.gd
	if dead == true:
		emit_signal("death", dead)


func _on_Player_mouse_entered():
	on_target = true


func _on_Player_mouse_exited():
	on_target = false

