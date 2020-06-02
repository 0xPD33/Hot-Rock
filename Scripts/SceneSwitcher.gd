# global (autoloaded) script for scene switching and passing parameters
extends Node

var _parameters = null


# changes the scene to chosen path and sets private _parameters equal to the given parameters on call
func change_scene(path, parameters=null):
	_parameters = parameters
	get_tree().change_scene(path)


# (used in the new scene) gets the parameters that were passed
func get_parameter(name):
	if _parameters != null:
		return _parameters[name]
	
	return null

