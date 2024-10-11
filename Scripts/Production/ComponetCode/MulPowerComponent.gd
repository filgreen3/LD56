class_name MulPowerComponent extends ProducitonComponent

@export var _label : Label
@export var _mul_value : int = 4
@export var progress_bar : ProductionProgressBar

func _ready() -> void:
	_mul_value = randi_range(2,max(2,sqrt(QuotaSystem.instance.levels_pass)))
	_label.text = "x"+str(_mul_value)

func _put_unit(unitNode : UnitNode, current_comp_id : int) -> void:
	progress_bar.start_bar(_time_to_process)
	await get_tree().create_timer(_time_to_process).timeout
	unitNode._power *= _mul_value
	super._put_unit(unitNode,current_comp_id)
