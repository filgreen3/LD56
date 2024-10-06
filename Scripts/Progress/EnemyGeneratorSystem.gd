class_name EnemyGeneratorSystem extends Node

@export var enemy_prefab : PackedScene
@export var x_line : int = 250

@export_category("Setting")
@export var time_system : TimeSystem
@export var quota_system : QuotaSystem
@export var move_system : MoveLimitSystem

func enemy_power_formule(level : int) -> int :  return pow(level, 2)

func get_power_for_enemy(level : int) -> int : return randi_range(enemy_power_formule(level)*0.6,enemy_power_formule(level)*1.2)

func _ready() -> void:
	while true :
		await get_tree().create_timer(randf_range(5, 10)/(1+quota_system.levels_pass)).timeout
		#await get_tree().create_timer(1).timeout debug
		spawn()
		
func spawn()->void:
	var new_hero : UnitNode = enemy_prefab.instantiate() as UnitNode
	get_tree().current_scene.add_child(new_hero)
	new_hero._power = max (get_power_for_enemy(quota_system.levels_pass), 1)
	new_hero.global_position.x = x_line
	new_hero.global_position.y = randi_range(move_system.y_low_limit, move_system.y_high_limit-16)
	new_hero.global_position.y = roundi(new_hero.global_position.y / GridNode.CLAMP_SCALE ) * GridNode.CLAMP_SCALE - 8
	new_hero._target_pos = new_hero.global_position
