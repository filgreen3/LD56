class_name ArrowShowerSystem extends Node

@export var dragSystem : DragAndDropSystem

static var instance : ArrowShowerSystem

signal on_show_arrow
signal on_hide_arrow

func _ready() -> void:
	instance = self
	dragSystem.on_take.connect(on_show_arrow.emit.unbind(1))
	dragSystem.on_drop.connect(on_hide_arrow.emit.unbind(1))
