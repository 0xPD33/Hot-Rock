extends Node2D

var running = false

onready var TutorialPopup1 = $CanvasLayer/HUD/TutorialPopup1

signal move_cam


func _ready():
	_initial_setup()


func _initial_setup():
	running = false
	connect("move_cam", $Camera2D, "_on_move_cam")
	emit_signal("move_cam", "offset_right")
	TutorialPopup1.popup()
	$CanvasLayer/HUD/RestartLabel.visible = false


func _process(delta):
	if running:
		emit_signal("move_cam", "move_right")
	else:
		emit_signal("move_cam", "stop_moving")
	
	_get_input()


func _get_input():
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()


func _on_Counter_start_game():
	running = true
	TutorialPopup1.queue_free()


func _on_Player_death():
	if running:
		running = false
		$Player.queue_free()
		$CanvasLayer/HUD/RestartLabel.visible = true

