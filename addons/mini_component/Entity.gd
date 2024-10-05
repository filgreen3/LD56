class_name Entity extends Node

@export var Components : Array[Component] 

func _ready() -> void:
	for child : Node in get_children(true):
		if child is Component:
			Components.append(child)

func get_componets(type : Script) -> Component:
	for component : Component in Components:
		if component.get_script() == type:
			return component
	return null
