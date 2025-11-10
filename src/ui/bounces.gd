extends Label

@onready var bounces: int = 0:
	set(x):
		bounces = x
		text = str(bounces)

func _on_light_bounced() -> void:
	bounces += 1
