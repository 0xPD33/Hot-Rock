extends Node2D

signal level_done


# emit's signal to finish the level in Game.gd
func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		emit_signal("level_done")


# play the color change animation once the portal enters the screen
func _on_VisibilityNotifier2D_screen_entered():
	$AnimationPlayer.play("portal_anim")

