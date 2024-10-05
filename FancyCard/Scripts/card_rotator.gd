class_name CardRotator extends FancyCardDrawer

@export_range (0,360) var _max_angle:float=15
@export_range (0,10) var _speed:float=1

@onready var angle_offset:float = randf()*3.14

func _process_card(card:Control, amount:float, delta:float)->void:
	card.rotation_degrees = amount*sin(angle_offset+Time.get_ticks_msec()*_speed*0.001)*_max_angle
	pass
