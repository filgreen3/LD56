class_name ProductionProgressBar extends ProducitonComponent

@export var start_progress_from_start : bool = false
@export var progress_bar : ProgressBar2D


func _init_production(productor : ProductionNode) -> void:
	super._init_production(productor)
	progress_bar.value = 0
	if start_progress_from_start:
		while true:
			await create_tween().tween_property(progress_bar,"value",1,_time_to_process).finished
			if !_productor.can_take_unit():
				await _productor.on_unit_release
			progress_bar.value = 0
			

func start_bar(time : float = 0) -> void:
	progress_bar.value = 0
	if time <= 0.01 : time = _time_to_process
	create_tween().tween_property(progress_bar,"value",1,time).finished
	
