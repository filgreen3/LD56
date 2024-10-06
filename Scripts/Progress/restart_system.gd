class_name RestartSystem extends Node

@export var time_system : TimeSystem
signal start_delay

var bool_go_to_restart : bool = false

func _ready() -> void:
	time_system.on_time_pass.connect(restart)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key_event : InputEventKey = event
		if key_event.physical_keycode == KEY_L:
			restart()

func restart()->void:
	get_tree().reload_current_scene()

func restart_delay()->void:
	if bool_go_to_restart : return
	bool_go_to_restart = true
	start_delay.emit()
	await get_tree().create_timer(3).timeout
	restart()
	
	
 
