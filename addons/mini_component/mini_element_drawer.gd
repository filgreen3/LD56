class_name MiniElementDrawer extends RichTextLabel

signal on_clicked(element : MiniElementDrawer)

var path_to_script : String

func _init() -> void:
	gui_input.connect(gui_input_handler)
	fit_content = true
	scroll_active = false
	mouse_entered.connect(func():modulate = Color.INDIAN_RED)
	mouse_exited.connect(func():modulate = Color.WHITE)

func gui_input_handler(event: InputEvent) -> void:
	if event is InputEventMouseButton and (event as InputEventMouseButton).pressed and (event as InputEventMouseButton).button_index == 1: 
		on_clicked.emit(self)
