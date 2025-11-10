extends Node2D

func _ready() -> void:
	$UI/Start.visible = true
	$UI/Levels.visible = false

#func start_game() -> void:
	#get_tree().change_scene_to_packed(MAIN_SCENE)
	
func exit_game() -> void:
	get_tree().quit()

func _on_exit_button_pressed() -> void:
	exit_game()

func _on_start_button_pressed() -> void:
	$UI/Levels.visible = true
	$UI/Start.visible = false
