class_name SpawnerComponent extends ProducitonComponent

@export var time_to_spawn_setting : float
@export var spawn_prefab : PackedScene
@export var count : int = 2

var current_time_to_spawn : float = 0 

func time_to_spawn() -> float: 
	var result : float = time_to_spawn_setting / _productor._product_speed
	if result < 0.1 : 
		result = 0.1
	return result

func _init_production(productor : ProductionNode) -> void:
	super._init_production(productor)
	current_time_to_spawn = time_to_spawn_setting

func _physics_process(delta: float) -> void:
	if _productor.enable :
		current_time_to_spawn -= delta
		if current_time_to_spawn < 0:
			_spawn()
			current_time_to_spawn = time_to_spawn_setting
	
func _spawn() -> void:
	var new_hero : UnitNode = spawn_prefab.instantiate() as UnitNode
	get_tree().current_scene.add_child(new_hero)
	new_hero._power = 1
	if _productor._get_output() != null :
		_productor._get_output()._put_unit(new_hero)
	_productor.on_unit_put.emit(new_hero)
