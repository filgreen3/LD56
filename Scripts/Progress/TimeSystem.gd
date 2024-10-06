class_name TimeSystem extends Node

@export var time_lable : Label
@export var max_time_max_level : int = 10
@export var time_curve : Curve 
@export var scale_time_parent : Control
@export var scale_shock : Vector2 = Vector2(0.7,1.2)


@export_category("Setting")
@export var quota_system : QuotaSystem

var make_time_pause : bool = false
var is_time_passed : bool = false

signal on_time_pass

var current_time : int :
	set (value) :
		current_time = value
		time_lable.text = str(current_time)

func _ready() -> void:
	start_timer()
	quota_system.quota_pass.connect(calculate_time.unbind(1))

func calculate_time() -> void:
	current_time = time_curve.sample(inverse_lerp(0,max_time_max_level, quota_system.get_current_level()))

func start_timer() -> void:
	calculate_time()
	while current_time > 0:
		if !make_time_pause:
			current_time -= 1
			shock_animation(scale_time_parent)
		await get_tree().create_timer(1).timeout
	on_time_pass.emit()

func shock_animation(control : Control) -> void:
	await create_tween().tween_property(control,"scale",scale_shock,0.1).finished
	await create_tween().tween_property(control,"scale",Vector2.ONE,0.2).finished
