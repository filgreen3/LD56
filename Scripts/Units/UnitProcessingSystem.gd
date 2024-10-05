class_name UnitProcessingSystem extends Node

static var instance : UnitProcessingSystem

signal on_team_move(team : int)

@export var max_team : int = 1
@export var time : float = 0.5

func _ready() -> void:
	instance = self
	while true:
		for i : int in max_team:
			await get_tree().create_timer(time).timeout
			on_team_move.emit(i)
