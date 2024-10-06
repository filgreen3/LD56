class_name ArrowInProduction extends ProducitonComponent

@export var my_node : Node2D

	
func _init_production(productor : ProductionNode) -> void:
	super._init_production(productor)
	productor.on_taken_to_drag.connect(func()->void: my_node.visible = true)
	productor.on_drop_to_drag.connect(func()->void: my_node.visible = false)
