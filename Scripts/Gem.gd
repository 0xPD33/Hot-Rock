extends Node2D


func _ready():
	add_to_group("Gems")


func _on_Area2D_body_entered(body: Node):
	if body is KinematicBody2D:
		get_tree().call_group("Game", "_on_gem_collected")
		queue_free()

