@icon("res://Sprites/Production/comp_icom.png")
class_name ProducitonComponent extends Node

var _productor : ProductionNode

func _init_production(productor : ProductionNode) -> void:
	_productor = productor
	pass

func _put_unit(unitNode : UnitNode) -> void:
	pass
