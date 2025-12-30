extends CharacterBody3D

const JUMP_VELOCITY = 5 

@onready var ih = $Input as InputHandler
@onready var state_machine = MovementStateMachine.new()

func _ready() -> void:
	add_child(state_machine)

func _physics_process(delta: float) -> void:
	
	ih.handleInput()
	
	# Update state machine
	state_machine.update_state(is_on_floor())
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Handle sprinting and speed transitions based on state
	var is_sprinting = Input.is_action_pressed("sprint")
	state_machine.handle_speed_transition(delta, direction, is_sprinting)
	
	# Apply acceleration-based movement using state-appropriate constants
	_apply_movement(delta, direction)

	move_and_slide()

func _apply_movement(delta: float, direction: Vector3) -> void:
	var move_acceleration = state_machine.get_move_acceleration()
	var friction = state_machine.get_friction()
	
	# Apply acceleration-based movement
	if direction:
		# Apply acceleration in the input direction
		var acceleration = direction * move_acceleration * delta
		velocity.x += acceleration.x
		velocity.z += acceleration.z
	else:
		# Apply friction when no input
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		velocity.z = move_toward(velocity.z, 0, friction * delta)
	
	# Cap horizontal velocity at max speed (walk or sprint)
	var horizontal_velocity = Vector2(velocity.x, velocity.z)
	if horizontal_velocity.length() > state_machine.current_speed:
		horizontal_velocity = horizontal_velocity.normalized() * state_machine.current_speed
		velocity.x = horizontal_velocity.x
		velocity.z = horizontal_velocity.y
