class_name AddPowerComponent extends ProducitonComponent

@export var _label : Label
@export var _add_value : int = 4

func _ready() -> void:
	_label.text = "+"+str(_add_value)

func _put_unit(unitNode : UnitNode) -> void:
	unitNode._power += _add_value
