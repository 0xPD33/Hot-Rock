extends Camera2D

var cam_speed = 500
var moving = false

onready var CamMovement = $CameraMovement


func _process(delta):
	if moving:
		position.x += cam_speed * delta
	elif moving == false:
		position.x = position.x


func _on_move_cam(anim_name):
	if anim_name == "offset_right":
		CamMovement.play("offset_right")
	elif anim_name == "move_right":
		moving = true
	elif anim_name == "stop_moving":
		moving = false

