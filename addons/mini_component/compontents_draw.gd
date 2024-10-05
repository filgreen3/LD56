@tool

class_name ComponetDrawer extends Node

@export var parent_componetn:Control

func _ready() -> void:
	pass
	
func fillPanel() -> void:
	clean_panel()
	var file_system : EditorFileSystemDirectory = EditorInterface.get_resource_filesystem().get_filesystem()
	var index = file_system.find_dir_index("Script")
	if index >= 0:
		find_in_folder(file_system.get_subdir(index))

func find_in_folder(file_system : EditorFileSystemDirectory)->void:
	var count := file_system.get_file_count()	
	for i in count:
		print(file_system.get_file(i))
		if file_system.get_file_script_class_name(i) != "":
			var new_lable : MiniElementDrawer = MiniElementDrawer.new()
			new_lable.text = file_system.get_file_script_class_name(i)
			new_lable.path_to_script = file_system.get_file_path(i)
			new_lable.on_clicked.connect(func(element:MiniElementDrawer):addCompToNode(element.path_to_script))
			parent_componetn.add_child(new_lable)
	count = file_system.get_subdir_count()
	for i in count:
		find_in_folder(file_system.get_subdir(i))
	
			
func clean_panel() -> void:
	for child in parent_componetn.get_children():
		child.queue_free()
	
func addCompToNode(pathComp: String)->void:
	var editorSelection: EditorSelection = EditorInterface.get_selection()
	var selectedNodes:Array[Node] = editorSelection.get_selected_nodes()
	if(selectedNodes.size()<=0): return
	
	var parentNode: Node = selectedNodes.front()

	var newComponentNode: Node = Node.new()
	newComponentNode.set_script(load(pathComp))
	newComponentNode.name = (newComponentNode.get_script() as Script).get_global_name()

	EditorInterface.edit_node(parentNode)
	parentNode.add_child(newComponentNode, true)
	newComponentNode.owner = EditorInterface.get_edited_scene_root()

	if(false):
		editorSelection.clear()
		editorSelection.add_node(newComponentNode)
		EditorInterface.edit_node(newComponentNode)

	print_debug(str("Added Component: ", newComponentNode, " → ", newComponentNode.get_parent()))
