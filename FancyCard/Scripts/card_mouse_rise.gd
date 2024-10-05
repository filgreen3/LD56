class_name CardMouseRise extends FancyCardDrawer

@export_range (-360,360) var _offset_y:float=15
@export_range (0,10) var _speed_move:float=1
@export_range (0,2) var _scale_mul:float=0.2
@export var _input_panel:Control
@export var _card_scale:CardScale



var _offset_value:float = 0
@onready var _input_panel_init_size:Vector2 = _input_panel.size
@onready var _card_panel_init_anchor_bottom :float = _card_panel.anchor_bottom

func _ready() -> void:
	_input_panel.mouse_entered.connect(func()->void:_amount=1)
	_input_panel.mouse_exited.connect(func()->void:_amount=0)

func _process_card(card:Control, amount:float, delta:float)->void:
	_offset_value = lerpf(_offset_value,lerpf(0,_offset_y,amount),delta*_speed_move)
	card.position = Vector2.UP * _offset_value
	_input_panel.size = _input_panel_init_size-_offset_value*Vector2.UP
	_input_panel.position = Vector2.UP * _offset_value
	_card_scale._amount = 1+_amount*_scale_mul
	

