class_name DragableComponent extends ProducitonComponent

const MOVE_DRAG_SPEED : float = 0.2


@export var area : Area2D
@export var max_scale : Vector2 = Vector2(1.05,1.3)
@export var time_to_scale : float = 0.2


var current_tween : Tween

func _init_production(productor : ProductionNode) -> void:
	super._init_production(productor)	
	area.input_event.connect(input_handler)
	pass

func _get_pos()-> Vector2 : return _productor.global_position

func _move(targetPoint : Vector2) -> void:
	_productor.global_position = lerp(_productor.global_position,targetPoint,MOVE_DRAG_SPEED)
	var dir : Vector2 = ((targetPoint - _productor.global_position)/16).limit_length(1)
	dir.x *= sign(dir.x) 
	dir.y *= sign(dir.y) 
	_productor.scale = lerp(_productor.scale , Vector2.ONE * 0.8 + dir * 0.4, 0.1)

func input_handler(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.is_pressed() && DragAndDropSystem.instance.can_take(self):
		DragAndDropSystem.instance.take(self)

func is_overlapping() -> bool : 
	return area.get_overlapping_areas().size() > 0

func _put_on_map() -> void:
	shock_scale()

func up_scale() -> void:
	if current_tween != null :
		current_tween.kill()
	current_tween = create_tween()
	current_tween.tween_property(_productor,"scale",max_scale, time_to_scale)

func down_scale() -> void:
	if current_tween != null :
		current_tween.kill()
	current_tween = create_tween()
	current_tween.tween_property(_productor,"scale",Vector2.ONE, time_to_scale)

func shock_scale() -> void:
	if current_tween != null :
		current_tween.kill()
	current_tween = create_tween()
	await current_tween.tween_property(_productor,"scale",max_scale, 0.1).finished
	current_tween = create_tween()
	await current_tween.tween_property(_productor,"scale",Vector2.ONE, 0.3).finished
