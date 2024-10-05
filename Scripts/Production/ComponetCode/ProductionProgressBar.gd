class_name ProductionProgressBar extends ProducitonComponent

@export var start_progress_from_start : bool = false
@export var progress_bar : ProgressBar2D
@export var time_def : float


func _init_production(productor : ProductionNode) -> void:
	super._init_production(productor)
	progress_bar.value = 0
	_productor.on_unit_put.connect(start_bar.unbind(1))
	if start_progress_from_start:
		while true:
			await create_tween().tween_property(progress_bar,"value",1,time_def).finished
			progress_bar.value = 0
			

func start_bar() -> void:
	await create_tween().tween_property(progress_bar,"value",1,time_def).finished
	progress_bar.value = 0
	
