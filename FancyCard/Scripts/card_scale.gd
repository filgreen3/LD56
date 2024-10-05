class_name CardScale extends FancyCardDrawer

@export_range (0,10) var _scale_amount:float=1
@export_range (0,10) var _scale_amount_cange_speed:float=1
@export_range (0,10) var _scale_velocity:float=1:
	get: 
		return _scale_velocity
	set(value): 
		_scale_velocity = value
@export_range (0,1) var _scale_drag:float=0.05


func _process_card(card:Control, amount:float, delta:float)->void:
	_scale_velocity *= 1-_scale_drag
	_scale_amount = lerpf(_scale_amount,amount,delta*_scale_amount_cange_speed)
	
	card.scale = Vector2.ONE*(_scale_amount+_scale_velocity)
