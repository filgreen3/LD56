class_name CardMouseClick extends FancyCardDrawer

@export_range (0,2) var _scale_mul:float=0.2
@export var _input_panel:Control
@export var _card_scale:CardScale
@export var _fancy_card:FancyCard


func _ready() -> void:
	_input_panel.gui_input.connect(_input_recived)

func _input_recived(event:InputEvent)->void:
	if(event is InputEventMouseButton):
		var cast : InputEventMouseButton = event as InputEventMouseButton
		if(cast.button_index==1 and cast.is_pressed()):
			_card_scale._scale_velocity = 1*_scale_mul
			_fancy_card._is_card_showed != _fancy_card._is_card_showed
		

