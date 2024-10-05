extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,true)
	get_viewport().transparent_bg = true
