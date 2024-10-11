@icon("res://Sprites/Production/comp_icom.png")
class_name ProducitonComponent extends Node

@export var _time_to_process : float = 0
var _productor : ProductionNode

func _init_production(productor : ProductionNode) -> void:
	_productor = productor

func _put_unit(unitNode : UnitNode, current_comp_id : int) -> void:
	if unitNode != null:
		await _productor.get_next_comp(current_comp_id)
	pass

func _put_on_map() -> void:
	pass
