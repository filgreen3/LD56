class_name ScoreGettingSystem extends Node

static var instance : ScoreGettingSystem

signal on_get_score(value : int)

@export var x_limit_to_score : int = 240
@export var score_lable : Label
@export var current_score : int = 0 : 
	set (value) :
		current_score = value
		score_lable.text = " Score : "+FancyNumber.format_number(value)
@export var quota_system : QuotaSystem
@export var scale_shock : Vector2 = Vector2(1.2,1.2)
@export var scale_shock_parent : Control

func _ready() -> void:
	instance = self
	current_score = 0
	quota_system.quota_pass.connect(add_score)
	
func add_score(power : int) -> void:
	var final : int = current_score + power
	create_tween().tween_property(self,"current_score", final, 0.5)
	on_get_score.emit(power)
	shock_animation(scale_shock_parent)

func shock_animation(control : Control) -> void:
	await create_tween().tween_property(control,"scale",scale_shock,0.1).finished
	await create_tween().tween_property(control,"scale",Vector2.ONE,0.3).finished
