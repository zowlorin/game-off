extends VBoxContainer

@export var PACKED_LEVEL: PackedScene

func load_level():
	if (!PACKED_LEVEL):
		printerr("Packed level not found?")
		return
	
	get_tree().change_scene_to_packed(PACKED_LEVEL)	
	
func play():
	load_level()

func _on_button_pressed() -> void:
	play()
