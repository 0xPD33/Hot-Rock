extends Control

var sound_volume : float

onready var SoundSlider = $MainContainer/PanelContainer/VBoxContainer/SoundContainer/SoundSlider


func _ready():
	SoundSlider.value = GlobalSettings.sound_volume
	SoundSlider.hint_tooltip = str(SoundSlider.value)


func _on_SoundSlider_value_changed(value):
	var slider_volume = value
	sound_volume = slider_volume
	SoundSlider.hint_tooltip = str(SoundSlider.value)


func apply_settings():
	GlobalSettings.sound_volume = sound_volume


func _on_ApplyButton_pressed():
	apply_settings()


func _on_OkayButton_pressed():
	apply_settings()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_CancelButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

