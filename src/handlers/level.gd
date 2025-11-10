extends Node2D

@onready var finished: bool = false

func exit():
	get_tree().change_scene_to_file("res://src/scenes/main_menu.tscn")
	
func start():
	pass

func finish():
	finished = true
	
	print("Level finished!")
	
	call_deferred("exit")

func _on_goal_reached() -> void:
	finish()
