extends Area2D

var velocity = Vector2()
var missile_speed = 600

onready var Player = get_node("/root/Level1/Player")

signal hit


func _ready():
	connect("hit", Player, "explode")


func _process(delta):
	translate(velocity * delta)
	check_for_collision()


func _physics_process(delta):
	set_position(get_position() + velocity * delta)


func starting_pos(dir, pos):
	set_rotation(dir)
	set_position(pos)
	velocity = Vector2(missile_speed, 0).rotated(dir * PI/2)


func check_for_collision():
	if $VisibilityNotifier2D.is_on_screen():
		if $HitDetection.is_colliding():
			emit_signal("hit", $HitDetection.get_collision_point(), $HitDetection.get_collider())


func _on_Timer_timeout():
	queue_free()

