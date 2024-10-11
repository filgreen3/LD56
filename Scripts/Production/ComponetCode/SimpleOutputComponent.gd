class_name SimpleOutputComponent extends OutPutComponent


@export var point_cast : ShapeCast2D
@export var point_cast_2 : ShapeCast2D
var stored_point : Vector2 

signal on_releas
func _put_unit(unitNode : UnitNode, current_comp_id : int) -> void:
	var targetObj : ProductionNode
	if point_cast_2 == null || randf() > 0.5:
		var t : int = point_cast.collision_result.size()
		if t > 0 && (point_cast.get_collider(0) as Node) != null:
			targetObj = (point_cast.get_collider(0) as Node).get_parent() as ProductionNode
		stored_point = point_cast.global_position
	else :
		var t : int = point_cast_2.collision_result.size()
		if t > 0 && (point_cast_2.get_collider(0) as Node) != null:
			targetObj = (point_cast_2.get_collider(0) as Node).get_parent() as ProductionNode
		stored_point = point_cast_2.global_position	
	
	if targetObj != null && targetObj != _productor:
		if targetObj.can_take_unit():
			targetObj._put_unit(unitNode)
		else:
			await targetObj.on_unit_release
			targetObj._put_unit(unitNode)
	else :
		on_releas.emit()
		unitNode.global_position = stored_point
		unitNode.process_mode = Node.PROCESS_MODE_INHERIT
		unitNode.visible = true
		unitNode._target_pos = stored_point
		unitNode.scale = Vector2.ZERO
		unitNode.create_tween().tween_property(unitNode,"scale",Vector2.ONE,0.1)
	_productor.on_unit_release.emit(unitNode)
	_productor.current_unit = null

