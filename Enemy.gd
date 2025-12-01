extends CharacterBody3D


@export var target: Node3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5




func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	
	
		
	var target_vector
	
	#print(str(velocity.x) + "    " + str(velocity.z))
	print(str(target.global_transform.origin.x))
	
	
	move_and_slide()
