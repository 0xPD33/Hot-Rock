extends Control

onready var AnimPlayer = $AnimationPlayer


func _ready():
	if not GlobalSettings.game_started:
		AnimPlayer.play("fade_in")
	
	GlobalSettings.game_started = true
	GlobalSettings.set_bus_volume()


func _on_PlayButton_pressed():
	AnimPlayer.play("fade_out")
	yield(AnimPlayer, "animation_finished")
	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")


func _on_SettingsButton_pressed():
	get_tree().change_scene("res://Scenes/Settings.tscn")


func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()

