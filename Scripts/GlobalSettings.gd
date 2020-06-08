# Global Settings script:
# currently only handles sound volume
extends Node

var sound_bus = AudioServer.get_bus_index("Sound")
var sound_volume : float


func set_bus_volume():
	AudioServer.set_bus_volume_db(sound_bus, sound_volume)

