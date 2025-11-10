extends RigidBody2D

signal bounced

func reduce_to_direction(vector: Vector2):
	return Vector2(sign(vector.x), sign(vector.y))

@onready var previous_direction: Vector2 = reduce_to_direction(linear_velocity)

func throw(force: Vector2):
	linear_velocity = Vector2.ZERO
	apply_impulse(force)

func _input(event: InputEvent) -> void:
	if !(event is InputEventMouseButton):
		return
		
	if (event.is_echo()):
		return
		
	if !(event.pressed):
		return
		
	if !(event.button_index == MOUSE_BUTTON_LEFT):
		return
		
	var direction = (get_global_mouse_position() - global_position).normalized() * 500
	
	throw(direction)
	
func on_bounce():
	bounced.emit()
	
	$BounceSFX.pitch_scale = randf_range(0.95, 1.05)
	$BounceSFX.play()

func _physics_process(delta: float) -> void:
	var direction: Vector2 = reduce_to_direction(linear_velocity)
	
	if (direction != previous_direction):
		on_bounce()
		
	previous_direction = direction
