class_name FancyCardDrawer extends Node

@export var _enable : bool = true
@export var _card_panel : Control
@export_range(0,1) var _amount : float = 0

func _process(delta: float) -> void:
	if(_enable):
		_process_card(_card_panel,_amount,delta)

func _process_card(card:Control, amount:float, delta:float)->void:
	pass
	
