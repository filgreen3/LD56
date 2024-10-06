class_name LinkLableToNode extends Control

var parent : Node2D
var offset : Vector2 = Vector2(-8,-11)

func _ready() -> void:
	parent = get_parent()
	global_position = parent.global_position + offset
