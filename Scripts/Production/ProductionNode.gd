@icon("res://Sprites/Production/producin_icon.png")
class_name ProductionNode extends GridNode

@export var enable : bool = true

@export_category("Stats")
@export var _product_speed : float = 1
@export var _time_to_produce : float = 1

@export_category("Basic")
@export var _production_name : String = "Product"
@export_multiline var _production_desciptison : String

var current_unit : UnitNode
var _comps : Array[ProducitonComponent]

signal on_unit_put(unitNode : UnitNode)
signal on_unit_release(unitNode : UnitNode)

signal on_taken_to_drag
signal on_drop_to_drag
 
func get_comp_by(id : int)-> ProducitonComponent:
	if id >= _comps.size():
		return null
	else: 
		return _comps[id]
		
func get_next_comp(current_id : int) -> void:
	var comp : ProducitonComponent = get_comp_by(current_id+1)
	if comp != null :
		comp._put_unit(current_unit, current_id+1)
	else :
		return

func _ready() -> void:
	for child : Node in get_children() :
		if child is ProducitonComponent : 
			_comps.append(child as ProducitonComponent)
	for comp : ProducitonComponent in _comps:
		comp._init_production(self)
		
func can_take_unit () -> bool :
	return current_unit == null
	
func _put_unit(unitNode : UnitNode) -> void:
	current_unit = unitNode
	on_unit_put.emit(unitNode)
	unitNode.visible = false
	unitNode.process_mode = Node.PROCESS_MODE_DISABLED
	await get_tree().create_timer(_time_to_produce).timeout
	await _comps[0]._put_unit(unitNode, 0)
		
func _put_on_map() -> void:
	for comp : ProducitonComponent in _comps:
		comp._put_on_map()

func _get_output() -> OutPutComponent :
	for comp : ProducitonComponent in _comps:
		if comp is OutPutComponent:
			return (comp as OutPutComponent)
	return null
	
