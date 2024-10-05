class_name ProductionStorageSystem extends Node

const FACTORY_SIZE : int = 32

@export var productors : Array[ProductionNode]
@export var center_position : Vector2
@export var spacing : float
@export var speed : float

func add_factory(factory : ProductionNode) -> void:
	if productors.has(factory) : return
	factory.enable = false
	productors.append(factory)
	productors.sort_custom(func(a : ProductionNode, b : ProductionNode)->bool: return a.global_position.x < b.global_position.x)

func remove_factory(factory : ProductionNode) -> void:
	if !productors.has(factory) : return
	factory.enable = true
	productors.erase(factory)
	
func _process(delta: float) -> void:
	for i : int in productors.size():
		var pos : Vector2 = center_position + Vector2.RIGHT * ((-productors.size()/2 + i + 0.5 * ((productors.size()+1)%2)) * (spacing + FACTORY_SIZE))
		productors[i].global_position = lerp(productors[i].global_position, pos, delta*speed)
