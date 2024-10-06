class_name DragAndDropSystem extends Node

static var instance : DragAndDropSystem

@export var storage_system : ProductionStorageSystem
@export var y_hights_point : int = 96

signal on_take(dragable : DragableComponent)
signal on_drop(dragable : DragableComponent)

var current_dragable : DragableComponent
var prev_pos : Vector2 
var curr_pos : Vector2 

func _ready() -> void:
	instance = self

func get_mouse_point()->Vector2 : 
	var pos : Vector2 = get_viewport().get_mouse_position()
	
	#pos.x -= 240
	#pos.y -= 150

	pos.x = roundi(pos.x / GridNode.CLAMP_SCALE ) * GridNode.CLAMP_SCALE - 8
	pos.y = roundi(pos.y / GridNode.CLAMP_SCALE ) * GridNode.CLAMP_SCALE - 8
	return pos

func _input(event: InputEvent) -> void:
	if current_dragable != null && \
	event is InputEventMouseButton && \
	!(event as InputEventMouseButton).is_pressed() :
		drop()	
	
func _process(delta: float) -> void:
	if current_dragable != null : 
		_move()
	
func _move() -> void:
	curr_pos = get_mouse_point()
	if (prev_pos - curr_pos).length_squared() > GridNode.CLAMP_SCALE * GridNode.CLAMP_SCALE:
		pass
		#current_dragable.shock_scale()

	prev_pos = curr_pos
	
	current_dragable._productor.modulate.a = 0.6 if is_bad_place() else 1
	
	current_dragable._move(curr_pos)
	
func take(dragable : DragableComponent ) -> void :
	current_dragable = dragable
	storage_system.remove_factory(current_dragable._productor)
	prev_pos = current_dragable._get_pos()
	on_take.emit(current_dragable)

func is_bad_place()->bool:
	return !MoveLimitSystem.instance.is_in_limit(curr_pos) || current_dragable.is_overlapping()

func drop() -> void :
	if is_bad_place():
		current_dragable._productor.modulate.a = 1
		storage_system.add_factory(current_dragable._productor)
	else :
		var remain_pos : Vector2 = curr_pos
		while (current_dragable._get_pos() - remain_pos).length_squared()>0.1:
			await get_tree().process_frame
			current_dragable._move(remain_pos)
		current_dragable._productor._put_on_map()
	on_drop.emit(current_dragable)
	current_dragable = null
	
	
func can_take(dragble : DragableComponent) -> bool :
	return current_dragable == null
