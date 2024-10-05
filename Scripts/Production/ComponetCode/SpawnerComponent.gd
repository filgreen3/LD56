class_name SpawnerComponent extends ProducitonComponent

@export var time_to_spawn_setting : float
@export var spawn_prefab : PackedScene
@export var count : int = 2

var timer : Timer

func time_to_spawn() -> float: 
	var result : float = time_to_spawn_setting / _productor._product_speed
	if result < 0.1 : 
		result = 0.1
	return result

func _init_production(productor : ProductionNode) -> void:
	super._init_production(productor)
	_spawning_process()

func _spawning_process() -> void:
	while true:
		await get_tree().create_timer(time_to_spawn()).timeout
		if count > 0 && _productor.enable:
			_spawn()
			count -= 1
		
func _spawn() -> void:
	var new_hero : UnitNode = spawn_prefab.instantiate() as UnitNode
	get_tree().current_scene.add_child(new_hero)
	if _productor._get_output() != null :
		_productor._get_output()._put_unit(new_hero)
	_productor.on_unit_put.emit(new_hero)
