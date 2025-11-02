extends Node2D

@export var MAIN_SCENE: PackedScene

func start_game():
	get_tree().change_scene_to_packed(MAIN_SCENE)

func _on_button_pressed() -> void:
	start_game()
