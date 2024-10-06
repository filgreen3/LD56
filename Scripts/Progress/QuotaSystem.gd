class_name QuotaSystem extends Node

static var instance : QuotaSystem

@export var score_system : ScoreGettingSystem
@export var quota_lable : Label
@export var scale_shock : Vector2 = Vector2(0.7,1.2)

signal quota_pass(quota : int)

var current_quota : int = 10 
var max_quota : int = 10
var levels_pass : int = 1 

func get_current_level() -> int : return levels_pass
 
func _ready() -> void:
	instance = self

func update_quota(score_added : int) -> void:
	current_quota -= score_added
	if current_quota < 0 :
		current_quota = 0
		levels_pass += 1
		quota_pass.emit(max_quota)
		max_quota = levels_pass * 10 * levels_pass
		current_quota = max_quota
	quota_lable.text = str(current_quota) + " : Quota "
	#shock_animation(quota_lable)

func shock_animation(control : Control) -> void:
	await create_tween().tween_property(control,"scale",scale_shock,0.1)
	await create_tween().tween_property(control,"scale",Vector2.ONE,0.5)
