class_name FancyDialog extends Control

@export var do_handle_input_as_skip : bool = true
@export var delay_to_show : float = 0.2
@export_multiline var base_text : String = "[charshake freq=1.0 span=0.6 amp=3]{text}[/charshake]"

@onready var fancy_text : RichTextLabel = $DialogWindow/RichTextLabel
@onready var audio_helper : AudioStreamPlayer = $AudioStreamPlayer
@onready var base_pitch : float = audio_helper.pitch_scale

signal end_phrase_show
signal request_next_phrase
signal end_dialog

var timer : Timer
var is_animating : bool 
var tween : Tween

var phrase_array : Array[String]
var current_phrase_id : int

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	#put_phrase("Onece upon a time in a old game, there was a @%!#^& \n Who was are ^!$%^!#!$^#%@#^")

func put_many_phrases(phrases : Array[String])->void:
	visible = true
	phrase_array = phrases
	current_phrase_id = 0
	put_phrase(phrase_array[current_phrase_id])
	await request_next_phrase
	for i : int in phrase_array.size()-1:
		current_phrase_id+=1
		put_phrase(phrase_array[current_phrase_id])
		await request_next_phrase
	visible=false
	end_dialog.emit()
	

func put_phrase(phrase : String, time : float = 1) -> void:
	visible = true
	audio_helper.pitch_scale = base_pitch
	if(time > 0):
		fancy_text.visible_ratio = 0
		is_animating = true
		if tween != null : tween.kill()
		tween = get_tree().create_tween().set_loops()
		tween.tween_property(fancy_text, "visible_ratio", 1, time).set_delay(delay_to_show).as_relative()
		tween.play()		
	fancy_text.text = base_text.format([phrase],"{text}")
	timer.start(delay_to_show)
	await timer.timeout
	var text_to_sample : int = phrase.length()/4
	var time_to_play : float = time / (text_to_sample)
	for i : int in text_to_sample:
		if not is_animating : break
		audio_helper.play()
		audio_helper.pitch_scale = lerpf(base_pitch,base_pitch+1,(i as float) / text_to_sample )
		timer.start(time_to_play)
		await timer.timeout
	is_animating = false
	end_phrase_show.emit()

func _input(event: InputEvent) -> void:
	if tween != null and do_handle_input_as_skip and event is InputEventKey and event.is_pressed():
		if(event as InputEventKey).keycode == KEY_SPACE:
			if is_animating:
				tween.kill()
				fancy_text.visible_ratio = 1
				is_animating = false
				end_phrase_show.emit()
			else:
				request_next_phrase.emit()
			
	
	
