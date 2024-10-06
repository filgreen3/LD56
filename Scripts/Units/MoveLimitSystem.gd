class_name MoveLimitSystem extends Node

static var instance : MoveLimitSystem

@export var y_high_max : int = 200 
@export var y_low_max : int = 200


@export var y_high_limit : int = 32 :
	set(value) :
		if value > y_high_max :
			value = y_high_max
		y_high_limit = value
		create_tween().tween_property(line_high,"global_position",Vector2.DOWN*value,0.5)
@export var line_high : Node2D


@export var y_low_limit : int = -32 :
	set(value) :
		if value < y_low_max :
			value = y_low_max
		y_low_limit = value
		create_tween().tween_property(line_low,"global_position",Vector2.DOWN*value,0.5)
@export var line_low : Node2D


func _ready() -> void:
	instance = self
	y_high_limit = y_high_limit
	y_low_limit = y_low_limit

func is_in_limit(point : Vector2, change_high_limit : float = 0, change_low_limit : float = 0) -> bool:
	return point.y > y_low_limit + change_low_limit && point.y < y_high_limit + change_high_limit
		
