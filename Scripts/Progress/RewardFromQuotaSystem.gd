class_name RewardFromQuotaSystem extends Node

@export var factory_array : Array[PackedScene]
@export var quota_system : QuotaSystem
@export var storage_system : ProductionStorageSystem

func _ready() -> void:
	quota_system.instance.quota_pass.connect(add_reward.unbind(1))

func add_reward() -> void :
	for i : int in 1:
		var new_factory : ProductionNode = (factory_array.pick_random() as PackedScene).instantiate() as ProductionNode
		new_factory.global_position = storage_system.center_position - Vector2.RIGHT*300
		add_child(new_factory)
		storage_system.add_factory(new_factory)
		await  get_tree().create_timer(0.2).timeout

func _input(event: InputEvent) -> void:
	if event is InputEventKey && (event as InputEventKey).keycode == KEY_0:
		add_reward()
