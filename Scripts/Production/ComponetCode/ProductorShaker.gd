class_name ProductorShaker extends ProducitonComponent

@export var node_to_shake : Node2D
@export var max_scale : Vector2

@export var attack_time : float = 0.1
@export var release_time : float = 0.3

@export var max_angle : float = 0.1
@export var rotate_time : float = 1


func _init_production(productor : ProductionNode) -> void:
	super._init_production(productor)
	_rotator_animation()
	
func _put_unit(unitNode : UnitNode, current_comp_id : int) -> void:
	_shacking()
	super._put_unit(unitNode,current_comp_id)

func _shacking() -> void:
	await get_tree().create_tween().tween_property(node_to_shake,"scale",max_scale,attack_time).finished 
	await get_tree().create_tween().tween_property(node_to_shake,"scale",Vector2.ONE,release_time).finished 

func _rotator_animation() -> void:
	while true:
		if is_inside_tree():
			await get_tree().create_tween().tween_property(node_to_shake,"rotation",-max_angle, rotate_time).finished 
		if is_inside_tree():
			await get_tree().create_tween().tween_property(node_to_shake,"rotation",max_angle, rotate_time).finished 
	
