class_name ProductionStorageSystem extends Node

const FACTORY_SIZE : int = 16

@export var max_size : int = 6
@export var productors : Array[ProductionNode]
@export var center_position : Vector2
@export var spacing : float
@export var speed : float


func add_factory(factory : ProductionNode) -> void:
	if productors.has(factory) : return
	
	if productors.size() + 1 > max_size:
		var factory_to_remove : ProductionNode = productors[productors.size()-1]
		remove_factory(factory_to_remove)
		factory_to_remove.create_tween().tween_property(factory_to_remove,"scale",Vector2.ZERO,0.2).finished.connect(func()->void:factory_to_remove.queue_free())
	
	factory.enable = false
	productors.append(factory)
	factory.create_tween().tween_property(factory,"scale",Vector2.ONE*1.3,0.3)
	productors.sort_custom(func(a : ProductionNode, b : ProductionNode)->bool: return a.global_position.x < b.global_position.x)

func remove_factory(factory : ProductionNode) -> void:
	if !productors.has(factory) : return
	factory.create_tween().tween_property(factory,"scale",Vector2.ONE,0.3)
	factory.enable = true
	productors.erase(factory)
	
func _process(delta: float) -> void:
	for i : int in productors.size():
		var pos : Vector2 = center_position + Vector2.RIGHT * ((-productors.size()/2 + i + 0.5 * ((productors.size()+1)%2)) * (spacing + FACTORY_SIZE))
		productors[i].global_position = lerp(productors[i].global_position, pos, delta*speed)
