class_name SpawnerComponent extends ProducitonComponent

@export var spawn_prefab : PackedScene
@export var count : int = 2
@export var progess_bar : ProductionProgressBar

var current_time_to_spawn : float = 0 

func time_to_spawn() -> float: 
	var result : float = _time_to_process / _productor._product_speed
	if result < 0.1 : 
		result = 0.1
	return result

func _init_production(productor : ProductionNode) -> void:
	super._init_production(productor)
	current_time_to_spawn = _time_to_process
	await _spawinig()

func _spawinig() -> void:
	while true:
		progess_bar.start_bar()
		await get_tree().create_timer(_time_to_process).timeout
		if _productor.enable :
				await _spawn()
	
func _spawn() -> void:
	var new_hero : UnitNode = spawn_prefab.instantiate() as UnitNode
	get_tree().current_scene.add_child(new_hero)
	new_hero._power = 1
	if _productor._get_output() != null :
		await _productor._get_output()._put_unit(new_hero, 0)
	_productor.on_unit_put.emit(new_hero)
