extends Control

onready var AnimPlayer = $AnimationPlayer


func _ready():
	AnimPlayer.play("fade_in")


func _on_BackButton_pressed():
	AnimPlayer.play("fade_out")
	yield(AnimPlayer, "animation_finished")
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

