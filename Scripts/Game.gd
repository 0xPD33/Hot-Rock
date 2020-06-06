# TODO:
# -> make all this code level-independent
extends Node2D

var running = false
var gems_collected : int
var max_gems : int

onready var Portal = get_node("Portal")

onready var TutPopup1 = $CanvasLayer/HUD/Tooltips/TutPopup1
onready var GemCount = $CanvasLayer/HUD/GemContainer/GemCountLabel

signal move_cam


func _ready():
	_initial_setup()
	add_to_group("Game")


func _initial_setup():
	running = false
	
	# connect signal move_cam to the Camera2D
	connect("move_cam", $Camera2D, "_on_move_cam")
	
	# tell the camera to offset to the right at the start of the game
	emit_signal("move_cam", "offset_right")
	
	# show the tutorial popup
	TutPopup1.popup()
	
	$CanvasLayer/HUD/RestartLabel.visible = false
	_setup_gems()


func _setup_gems():
	# get all gems that are in the level
	max_gems = get_tree().get_nodes_in_group("Gems").size()
	_update_gems()


func _update_gems():
	GemCount.text = str(gems_collected) + "/" + str(max_gems)


func _process(delta):
	_control_camera()
	_get_input()


func _control_camera():
	# tells the camera when to start moving right and when to stop (emits signals to Camera.gd)
	if running:
		emit_signal("move_cam", "move_right")
	else:
		emit_signal("move_cam", "stop_moving")


func _get_input():
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_Counter_start_game():
	# this code runs when the HUD Counter runs out
	if running == false:
		running = true
		TutPopup1.queue_free()
	else:
		pass


# runs when the player is dead and double checks for that
func _on_Player_death(is_dead):
	if running and is_dead:
		running = false
		
		# free the player and show the RestartLabel
		$Player.queue_free()
		$CanvasLayer/HUD/RestartLabel.visible = true


func _on_Portal_level_done():
	if running:
		running = false
		
		$Player.queue_free()
		
		# gets the AnimationPlayer node named ZoomAnimation from the Portal and
		# waits for any running animation to finish
		var portal_zoom = Portal.get_node("ZoomAnimation")
		yield(portal_zoom, "animation_finished")
		
		# change the scene to the LevelDone scene
		SceneSwitcher.change_scene("res://Scenes/LevelDone.tscn", {"gems_collected": gems_collected, "max_gems": max_gems})


func _on_gem_collected():
	# increments gems_collected by 1 each time the player collects a gem (duh)
	gems_collected += 1
	_update_gems()

