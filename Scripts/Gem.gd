extends Node2D

var collected = false


func _ready():
	add_to_group("Gems")


func _on_Area2D_body_entered(body: Node):
	# check if it's the player and check if the gem has already been 
	# collected to prevent the gem from being collected twice
	if body is KinematicBody2D and !collected:
		collected = true
		vanish()
		yield($VanishAnimation, "animation_finished")
		get_tree().call_group("Game", "_on_gem_collected")
		queue_free()


func vanish():
	$AudioStreamPlayer2D.play()
	$VanishAnimation.play("gem_vanish")

