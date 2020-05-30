extends Node2D

var running = false
var gems_collected : int
var max_gems : int

onready var TutPopup1 = $CanvasLayer/HUD/Tooltips/TutPopup1
onready var GemCount = $CanvasLayer/HUD/HBoxContainer/GemCountLabel

signal move_cam


func _ready():
	_initial_setup()
	add_to_group("Game")


func _initial_setup():
	running = false
	connect("move_cam", $Camera2D, "_on_move_cam")
	emit_signal("move_cam", "offset_right")
	TutPopup1.popup()
	$CanvasLayer/HUD/RestartLabel.visible = false
	$CanvasLayer/HUD/LevelDoneLabel.visible = false
	_setup_gems()


func _setup_gems():
	max_gems = get_tree().get_nodes_in_group("Gems").size()
	_update_gems()


func _update_gems():
	GemCount.text = ": " + str(gems_collected) + "/" + str(max_gems)


func _process(delta):
	if running:
		emit_signal("move_cam", "move_right")
	else:
		emit_signal("move_cam", "stop_moving")
	
	_get_input()
	_update_gems()


func _get_input():
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()


func _on_Counter_start_game():
	if running == false:
		running = true
		TutPopup1.queue_free()
	else:
		pass


func _on_Player_death():
	if running:
		running = false
		$Player.queue_free()
		$CanvasLayer/HUD/RestartLabel.visible = true


func _on_Portal_level_done():
	if running:
		running = false
		$Player.queue_free()
		$CanvasLayer/HUD/LevelDoneLabel.visible = true


func _on_gem_collected():
	gems_collected += 1

