class_name FancyCard extends Control

signal card_show
signal card_hide

var _is_card_showed : bool = false : 
	set(value) :
		if value == _is_card_showed : return
		elif value : 
			card_show.emit()
		else :
			card_hide.emit()
		_is_card_showed = value

@export var _effect_amount_change : Signal
@export var _amount : float = 0 :
	get:
		return _amount
	set(value):
		_amount = clamp(value,0,1)
		_effect_amount_change.emit(_amount)

@export var icon : TextureRect
@export var title : Label
@export var text : Label
