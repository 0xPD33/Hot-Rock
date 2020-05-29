extends Control

var display_value = 5

onready var timer = $Timer
onready var counter = $CenterContainer/Label

signal start_game


func _ready():
	counter.text = str(display_value)
	
	timer.set_wait_time(1)
	timer.start()


func _on_Timer_timeout():
	display_value -= 1
	
	counter.text = str(display_value)
	
	if display_value == 0:
		queue_free()
		emit_signal("start_game")

