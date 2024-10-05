@tool
extends RichTextEffect
class_name RichTextGhost

# Syntax: [ghost freq=5.0 span=10.0][/ghost]

# Define the tag name.
var bbcode : String = "ghost"

func _process_custom_fx(char_fx : CharFXTransform)->bool:
	# Get parameters, or use the provided default value if missing.
	var speed : float = char_fx.env.get("freq", 5.0)
	var span : float = char_fx.env.get("span", 10.0)

	var alpha : float = sin(char_fx.elapsed_time * speed + (char_fx.range.x / span)) * 0.5 + 0.5
	char_fx.color.a = alpha
	return true
