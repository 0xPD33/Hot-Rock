# Global Settings script:
# currently only handles sound volume and detects if the game started
extends Node

var game_started : float

var sound_bus = AudioServer.get_bus_index("Sound")
var sound_volume : float


func set_bus_volume():
	AudioServer.set_bus_volume_db(sound_bus, sound_volume)

