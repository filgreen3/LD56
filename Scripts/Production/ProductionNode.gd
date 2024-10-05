@icon("res://Sprites/Production/producin_icon.png")
class_name ProductionNode extends GridNode

@export var enable : bool = true

@export_category("Stats")
@export var _product_speed : float = 1
@export var _time_to_produce : float = 1

@export_category("Basic")
@export var _production_name : String = "Product"
@export_multiline var _production_desciptison : String

var _can_take_unit : bool = true
var _comps : Array[ProducitonComponent]

signal on_unit_put(unitNode : UnitNode)
signal on_unit_release(unitNode : UnitNode)

func _ready() -> void:
	for child : Node in get_children() :
		if child is ProducitonComponent : 
			_comps.append(child as ProducitonComponent)
	for comp : ProducitonComponent in _comps:
		comp._init_production(self)
	
func _put_unit(unitNode : UnitNode) -> void:
	on_unit_put.emit(unitNode)
	unitNode.visible = false
	unitNode.process_mode = Node.PROCESS_MODE_DISABLED
	await get_tree().create_timer(_time_to_produce).timeout
	for comp : ProducitonComponent in _comps:
		comp._put_unit(unitNode)
	
func _get_output() -> OutPutComponent :
	for comp : ProducitonComponent in _comps:
		if comp is OutPutComponent:
			return (comp as OutPutComponent)
	return null
	
