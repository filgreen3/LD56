class_name AddPowerComponent extends ProducitonComponent

@export var _label : Label
@export var _add_value : int = 4
@export var progress_bar : ProductionProgressBar

func _ready() -> void:
	_add_value = 2*QuotaSystem.instance.levels_pass
	_add_value = max(randi_range(_add_value*0.7, _add_value*1.2),5)
	_label.text = "+"+str(_add_value)

func _put_unit(unitNode : UnitNode, current_comp_id : int) -> void:
	progress_bar.start_bar(_time_to_process)
	await get_tree().create_timer(_time_to_process).timeout
	unitNode._power += _add_value
	await super._put_unit(unitNode,current_comp_id)

