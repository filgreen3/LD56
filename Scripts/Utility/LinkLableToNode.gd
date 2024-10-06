class_name LinkLableToNode extends Control

@export var parent : Node2D
@export var offset : Vector2 = Vector2(-8,-11)

func _ready() -> void:
	position = offset

func _process(delta: float) -> void:
	rotation = parent.rotation
	scale = parent.scale
