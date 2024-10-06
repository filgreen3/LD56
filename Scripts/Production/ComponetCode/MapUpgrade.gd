class_name MapUpgrade extends ProducitonComponent

@export_enum("UP","DOWN") var dir_upgrade : String
@export var junk : Node

func _put_on_map() -> void:
	junk.process_mode = Node.PROCESS_MODE_DISABLED
	if dir_upgrade == "DOWN":
		MoveLimitSystem.instance.y_high_limit += 16
	elif dir_upgrade == "UP" :
		MoveLimitSystem.instance.y_low_limit -= 16
	await create_tween().tween_property(_productor,"scale",Vector2.ZERO,0.2).finished
	_productor.queue_free()
