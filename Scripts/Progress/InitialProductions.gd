class_name InitialProductions extends Node

@export var fabrics_prefabs : Array[PackedScene]
@export var fabric_storage : ProductionStorageSystem

func _ready() -> void:
	for prefab : PackedScene in fabrics_prefabs :
		await get_tree().create_timer(0.2).timeout
		var fabric : ProductionNode = prefab.instantiate() as ProductionNode
		fabric.global_position = -Vector2.UP * 180
		add_child(fabric)
		fabric_storage.add_factory(fabric)
