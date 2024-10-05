class_name DragAndDropSystem extends Node

static var instance : DragAndDropSystem

var current_dragable : DragableComponent

func _ready() -> void:
	instance = self

func get_mouse_point()->Vector2 : 
	var pos : Vector2 = get_viewport().get_mouse_position()
	
	pos.x -= 240
	pos.y -= 150
	
	pos.x = roundi(pos.x / GridNode.CLAMP_SCALE ) * GridNode.CLAMP_SCALE
	pos.y = roundi(pos.y / GridNode.CLAMP_SCALE ) * GridNode.CLAMP_SCALE
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
	current_dragable._move(get_mouse_point())
	
func take(dragable : DragableComponent ) -> void :
	current_dragable = dragable

func drop() -> void :
	current_dragable = null
	
func can_take(dragble : DragableComponent) -> bool :
	return current_dragable == null
