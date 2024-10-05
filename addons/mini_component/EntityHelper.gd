@tool class_name EntityHelper extends Node

@export var no_entity_panel : Control 
@export var entity_make_button : Button

func _enter_tree() -> void:
	EditorInterface.get_selection().selection_changed.connect(update_label)
	entity_make_button.button_down.connect(make_node_entity)

func _exit_tree() -> void:
	EditorInterface.get_selection().selection_changed.disconnect(update_label)
	entity_make_button.button_down.disconnect(make_node_entity)
	
func get_selection_first_node() -> Node:
	var editorSelection: EditorSelection = EditorInterface.get_selection()
	var selectedNodes : Array[Node] = editorSelection.get_selected_nodes()
	if(selectedNodes.size()<=0): return null
	
	var targetNode: Node = selectedNodes.front() as Node
	return targetNode
	
func update_label() -> void:
	no_entity_panel.visible = not is_entity()

func is_entity() -> bool:
	var targetNode = get_selection_first_node()
	return targetNode.get_script() == Entity
	
func make_node_entity() -> void:
	var targetNode = get_selection_first_node()
	if(targetNode == null or targetNode.get_script() != null):
		targetNode.set_script(Entity)
		update_label()
	
	
