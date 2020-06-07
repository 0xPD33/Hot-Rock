extends Control

onready var AnimPlayer = $AnimationPlayer


func _ready():
	AnimPlayer.play("fade_in")


func _on_PlayButton_pressed():
	AnimPlayer.play("fade_out")
	# waits for the fade_out animation to finish before changing to the level scene
	yield(AnimPlayer, "animation_finished")
	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()

