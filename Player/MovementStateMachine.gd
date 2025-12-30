extends Node
class_name MovementStateMachine

enum MovementState {
	GROUND,
	AIR
}

# Ground physics constants
const GROUND_SPEED = 8.0
const GROUND_SPRINT_SPEED = 12.5
const GROUND_ACCELERATION = 10.0  # Speed increase per second (for sprint transition)
const GROUND_DECELERATION = 30.0  # Speed decrease per second (for sprint transition)
const GROUND_MOVE_ACCELERATION = 80.0  # Movement acceleration force
const GROUND_FRICTION = 80.0  # Friction to slow down when no input

# Air physics constants
const AIR_SPEED = 8.0
const AIR_SPRINT_SPEED = 12.5
const AIR_ACCELERATION = 5.0  # Speed decrease per second (for sprint transition)
const AIR_MOVE_ACCELERATION = 30.0  # Movement acceleration force (lower for realism)
const AIR_FRICTION = 10.0  # Friction in air (less than ground)

var current_state: MovementState = MovementState.GROUND
var current_speed = GROUND_SPEED

func update_state(is_on_floor: bool) -> void:
	if is_on_floor:
		current_state = MovementState.GROUND
	else:
		current_state = MovementState.AIR

func handle_speed_transition(delta: float, direction: Vector3, is_sprinting: bool) -> void:
	match current_state:
		MovementState.GROUND:
			if is_sprinting and direction != Vector3.ZERO:
				# Smoothly accelerate towards sprint speed
				current_speed = move_toward(current_speed, GROUND_SPRINT_SPEED, GROUND_ACCELERATION * delta)
			else:
				# Smoothly decelerate back to normal speed
				current_speed = move_toward(current_speed, GROUND_SPEED, GROUND_DECELERATION * delta)
		
		MovementState.AIR:
			# Slowly transition sprint speed back to normal in air
			current_speed = move_toward(current_speed, AIR_SPEED, AIR_ACCELERATION * delta)

func get_move_acceleration() -> float:
	match current_state:
		MovementState.GROUND:
			return GROUND_MOVE_ACCELERATION
		MovementState.AIR:
			return AIR_MOVE_ACCELERATION
	return GROUND_MOVE_ACCELERATION

func get_friction() -> float:
	match current_state:
		MovementState.GROUND:
			return GROUND_FRICTION
		MovementState.AIR:
			return AIR_FRICTION
	return GROUND_FRICTION

