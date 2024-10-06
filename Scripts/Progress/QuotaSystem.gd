class_name QuotaSystem extends Node

static var instance : QuotaSystem

@export var score_system : ScoreGettingSystem
@export var quota_lable : Label
@export var scale_shock : Vector2 = Vector2(0.7,1.2)
@export var x_limit_to_get_more_quota : float = 0
@export var quota_lable_scale_parent : Control
@export var red_color : Color

signal quota_pass(quota : int)

var current_quota : int = 5
var display_quota : int :
	set (value) :
		display_quota = value
		quota_lable.text = str(display_quota) + " : Quota "
		
var max_quota : int = 10
var levels_pass : int = 1 

func get_current_level() -> int : return levels_pass
 
func _ready() -> void:
	instance = self
	current_quota = current_quota
	display_quota = current_quota

func update_quota(score_added : int) -> void:
	current_quota -= score_added
	if current_quota < 0 :
		current_quota = 0
		levels_pass += 1
		quota_pass.emit(max_quota)
		max_quota = 5 + levels_pass * levels_pass
		current_quota = max_quota
	if score_added < 0:
		shock_animation(quota_lable_scale_parent)
		quota_lable_scale_parent.modulate = red_color
		create_tween().tween_property(quota_lable_scale_parent,"modulate",Color.WHITE,0.3).finished
	create_tween().tween_property(self,"display_quota",current_quota,0.4)

func shock_animation(control : Control) -> void:
	await create_tween().tween_property(control,"scale",scale_shock,0.1).finished
	await create_tween().tween_property(control,"scale",Vector2.ONE,0.3).finished
