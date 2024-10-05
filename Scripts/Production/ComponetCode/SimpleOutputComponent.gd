class_name SimpleOutputComponent extends OutPutComponent


@export var point_cast : ShapeCast2D

func get_point() -> Vector2 : return point_cast.global_position

func _put_unit(unitNode : UnitNode) -> void:
	var targetObj : ProductionNode
	
	if point_cast.is_colliding && point_cast.get_collider(0) != null:
		targetObj = (point_cast.get_collider(0) as Node).get_parent() as ProductionNode
	
	if targetObj != null && targetObj != _productor:
		targetObj._put_unit(unitNode)
	else :
		unitNode.global_position = get_point()
		unitNode.process_mode = Node.PROCESS_MODE_INHERIT
		unitNode.visible = true
		unitNode._target_pos = get_point()
	_productor.on_unit_release.emit(unitNode)
