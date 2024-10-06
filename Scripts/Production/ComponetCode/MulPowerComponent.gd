class_name MulPowerComponent extends ProducitonComponent

@export var _label : Label
@export var _mul_value : int = 4

func _ready() -> void:
	_mul_value = randi_range(2,max(2,sqrt(QuotaSystem.instance.levels_pass)))
	_label.text = "x"+str(_mul_value)

func _put_unit(unitNode : UnitNode) -> void:
	unitNode._power *= _mul_value
