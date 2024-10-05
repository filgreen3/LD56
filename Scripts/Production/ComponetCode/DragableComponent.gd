class_name DragableComponent extends ProducitonComponent

const MOVE_DRAG_SPEED : float = 0.1


@export var body : StaticBody2D
@export var max_scale : Vector2 = Vector2(1.05,1.3)
@export var time_to_scale : float = 0.1

var current_tween : Tween

func _init_production(productor : ProductionNode) -> void:
	super._init_production(productor)	
	body.input_event.connect(input_handler)
	pass

func _get_pos()-> Vector2 : return _productor.global_position

func _move(targetPoint : Vector2) -> void:
	_productor.global_position = lerp(_productor.global_position,targetPoint,MOVE_DRAG_SPEED)

func input_handler(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.is_pressed() && DragAndDropSystem.instance.can_take(self):
		DragAndDropSystem.instance.take(self)
		
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
	await current_tween.tween_property(_productor,"scale",max_scale, time_to_scale/2).finished
	current_tween = create_tween()
	await current_tween.tween_property(_productor,"scale",Vector2.ONE, time_to_scale/2).finished
