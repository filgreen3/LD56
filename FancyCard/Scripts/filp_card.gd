class_name FlipCard extends FancyCardDrawer

@export var _speed_change : float
@export var _card_front : Control
@export var _card_back : Control
@export var _title_text : Label
@export var _main_text : Label
@export var _input_panel:Control
@export var _curve:Curve
@export var _fancy_card:FancyCard

var target_amount : float

func _ready() -> void:
	_fancy_card.card_show.connect(func()->void:_amount = 1)
	_fancy_card.card_hide.connect(func()->void:_amount = 0)
	#if t target 1 = scale 0
	#if a target 1 = scale 0

func _process_card(card:Control, amount:float, delta:float)->void:
	_title_text.modulate.a = (target_amount-0.5)*2
	_main_text.modulate.a = _title_text.modulate.a
	
	target_amount += sign(amount-target_amount)*_speed_change*delta
	_card_front.scale.x = lerpf(0,3,_curve.sample(target_amount))
	_card_back.scale.x = lerpf(0,3,_curve.sample(1-target_amount))


