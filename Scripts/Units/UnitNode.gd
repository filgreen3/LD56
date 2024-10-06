class_name UnitNode extends CharacterBody2D

const STANDART_OFFSET : float = 16

@export_category("Stats")
@export var _power : int = 1 :
	set (value):
		if value < 0:
			value = 0
		_power = value
		_power_display.text = str(value)
	
@export var _basic_speed : int = 1

@export_category("Setting")
@export var _power_display : Label
@export var _items : Array[Item]
@export var _shape : ShapeCast2D 
@export var _self_shape_cast : ShapeCast2D 
@export var _team : int
@export var _move_dir : Vector2 = Vector2(1,0)

func y_lowest_point() -> float: return MoveLimitSystem.instance.y_low_limit
func y_heights_point() -> float: return MoveLimitSystem.instance.y_high_limit

signal on_target_reached

var _is_in_town : bool = true
var _dir : Vector2
var _target_pos : Vector2
var _is_target_reached : bool = false
var _next_enemy : UnitNode

func _ready() -> void:
	_unit_logic()

func _unit_logic() -> void:
	on_target_reached.connect(move_when_in_town)

func _process(delta: float) -> void:
	if _is_target_reached : return
	_dir = _target_pos - global_position
	move_and_collide(_dir*delta*_basic_speed * STANDART_OFFSET)
	if _dir.length_squared() < 0.1 :
		battle_handler()
		_is_target_reached = true
		if global_position.x > ScoreGettingSystem.instance.x_limit_to_score:
			QuotaSystem.instance.update_quota(_power)
			queue_free()
		on_target_reached.emit()

func battle_handler() -> void:
	if(_next_enemy!=null):
			var enemy_power : int = _next_enemy._power
			_next_enemy._power -= _power
			if _next_enemy._power <= 0:
				_next_enemy.queue_free()
			_power -= enemy_power
			if _power <= 0:
				queue_free()


func add_item(item : Item) -> void:
	_items.append(item)
	add_child(item)
	item.given_to_unit(self)

func move_when_in_town() -> void : 
	if !_self_shape_cast.is_colliding():
		await get_tree().create_timer(0.5).timeout
	await check_for_empty_space()
	_is_target_reached = false


func get_new_target_pos()->void:
	var rand_vector : Vector2
	if randf() > 0.5:
		rand_vector = _move_dir
	else :
		rand_vector = Vector2.UP * signf(randf()-0.5)
	rand_vector *= STANDART_OFFSET

	if (global_position + rand_vector).y < y_lowest_point() || (global_position + rand_vector).y > y_heights_point():
		rand_vector.y = -rand_vector.y

	_shape.position = rand_vector 
	_target_pos = global_position + rand_vector
	#_target_pos.x = roundi(_target_pos.x / STANDART_OFFSET ) * STANDART_OFFSET + 8
	#_target_pos.y = roundi(_target_pos.y / STANDART_OFFSET ) * STANDART_OFFSET + 8

func check_for_empty_space() -> void:
	get_new_target_pos()
	await get_tree().create_timer(0.1).timeout
	if check_if_next_is_enemy():
		return
	while _shape.is_colliding():
		get_new_target_pos()
		if !_self_shape_cast.is_colliding():
			await get_tree().create_timer(0.5).timeout
		else:
			await get_tree().process_frame 
			

func check_if_next_is_enemy() -> bool:
	if _shape.is_colliding() && _shape.get_collider(0) is Node && (_shape.get_collider(0) as Node).get_parent() is UnitNode:
		var enemy : UnitNode = (_shape.get_collider(0) as Node).get_parent() as UnitNode
		if enemy._team != _team :
			_next_enemy = enemy
			return true
	return false
