class_name RewardFromQuotaSystem extends Node

@export var factory_array : Array[PackedScene]
@export var quota_system : QuotaSystem
@export var storage_system : ProductionStorageSystem

func _ready() -> void:
	quota_system.instance.quota_pass.connect(add_reward.unbind(1))

func add_reward() -> void :
	var new_factory : ProductionNode = (factory_array.pick_random() as PackedScene).instantiate() as ProductionNode
	add_child(new_factory)
	storage_system.add_factory(new_factory)
