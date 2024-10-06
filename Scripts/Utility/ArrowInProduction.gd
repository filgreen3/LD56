class_name ArrowInProduction extends Node2D

@export var _production : ProductionNode

func _ready() -> void:
	if ArrowShowerSystem.instance == null:
		await get_tree().create_timer(0.1).timeout
	ArrowShowerSystem.instance.on_show_arrow.connect(func()->void:visible=_production.enable)
	ArrowShowerSystem.instance.on_hide_arrow.connect(func()->void:visible=false)
	
