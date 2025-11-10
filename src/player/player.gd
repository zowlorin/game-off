extends CharacterBody2D

func prioritize_axis(direction: Vector2, horizontal: bool):
	if (direction.x && horizontal):
		return Vector2(direction.x, 0)
		
	if (direction.y && !horizontal):
		return Vector2(0, direction.y)
		
	return direction

@export var MOVE_SPEED: float
@export var MOVE_ACCEL: float
@export var MOVE_DECEL: float

@export var JUMP_HEIGHT: float
@export var FALL_TIME: float

@export var DASH_SPEED: float

@onready var personal_gravity: float = 2 * JUMP_HEIGHT / (FALL_TIME * FALL_TIME)
@onready var jump_velocity: float = 2 * JUMP_HEIGHT / FALL_TIME

@onready var coyote_available: bool = false

@onready var was_on_floor: bool = false
@onready var jump_queued: bool = false

@onready var dashing: bool = false
@onready var dash_direction: Vector2 = Vector2.ZERO

func update_gravity(delta: float):
	if (is_on_floor()):
		velocity.y = min(velocity.y, 0)
		return
		
	velocity.y += personal_gravity * delta
	
func queue_jump():
	if (jump_queued):
		return
		
	$JumpQueueTimer.start()
	jump_queued = true
	
func attempt_jump():
	if (dashing):
		return
		
	if (!is_on_floor() && !coyote_available):
		queue_jump()
		return
		
	jump()
	
func jump():
	velocity.y = -jump_velocity
	jump_queued = false
	
func dash():
	var dash_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	dashing = true
	
	$DashTimer.start()
	
	dash_direction = dash_direction.normalized()
	
	velocity = dash_direction * DASH_SPEED

func update_horizontal_movement(delta: float):
	if (dashing):
		return
		
	var h_move_direction: float = Input.get_axis("move_left", "move_right")
	
	if (h_move_direction):
		velocity.x = move_toward(velocity.x, h_move_direction * MOVE_SPEED, MOVE_DECEL * delta)
			
	else:
		velocity.x = move_toward(velocity.x, 0, MOVE_ACCEL * delta)
			
func _physics_process(delta: float) -> void:
	if (is_on_floor() != was_on_floor):
		$CoyoteTimer.start()

	if (Input.is_action_just_pressed("move_jump") || jump_queued):
		attempt_jump()
		
	if (Input.is_action_just_pressed("move_dash")):
		dash()
		
	was_on_floor = is_on_floor()
		
	update_horizontal_movement(delta)
	update_gravity(delta)
	
	move_and_slide()
	
func _on_coyote_timer_timeout() -> void:
	coyote_available = false

func _on_jump_queue_timer_timeout() -> void:
	jump_queued = false

func _on_dash_timer_timeout() -> void:
	dashing = false
