extends Control

# gets the parameter from the SceneSwitcher
var gems_collected = SceneSwitcher.get_parameter("gems_collected")
var max_gems = SceneSwitcher.get_parameter("max_gems")

onready var GemsLabel = $Panel/VBoxContainer/CollectedGems
onready var Stars = $Panel/Stars


func _ready():
	calculate_gems(gems_collected, max_gems)
	GemsLabel.text = "Collected Gems: " + str(gems_collected) + "/" + str(max_gems)


# calculates the gems and sets star_var accordingly. star_var represents the number of stars
# it works but this could probably be done much more efficient
func calculate_gems(gems_collected, max_gems):
	var star_var : int
	
	if gems_collected >= int((round(max_gems * 0.33))) and gems_collected < int((round(max_gems * 0.66))):
		star_var = 1
	elif gems_collected >= int((round(max_gems * 0.66))) and gems_collected < max_gems:
		star_var = 2 
	elif gems_collected == max_gems:
		star_var = 3
	else:
		star_var = 0
	
	calculate_stars(star_var)


# change the Stars rect_size.x according to star_var.
# the Stars TextureRect is actually just a single star texture that has been set to "Tile".
# resizing x will result in multiple stars being drawn on screen.
func calculate_stars(star_var):
	match star_var:
		1:
			Stars.rect_size.x = 90
		2:
			Stars.rect_size.x = 180
		3:
			Stars.rect_size.x = 270
		_:
			Stars.queue_free()


# restarts the level
func _on_RestartButton_pressed():
	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")

