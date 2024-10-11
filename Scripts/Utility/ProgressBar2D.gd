class_name ProgressBar2D extends Node2D

@export var bar_size : int = 24
@export var front_bar : Node2D
@export var value : float : 
	set(val):
		value = clampf(val,0,1)
		front_bar.position = Vector2.RIGHT * lerpf(-bar_size, 0, value)
		visible = value > 0.001
	 
