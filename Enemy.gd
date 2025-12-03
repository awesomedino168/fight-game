extends CharacterBody3D


@export var target: Node3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	

	pass # Replace with function body.





func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("dupe"):
		var dupe = self.duplicate()
		get_parent().add_child.call_deferred(dupe)
		dupe.position = Vector3(position.x, position.y+10, position.z)
		print("duplicated")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	
		
	
	
		
	var target_vector = Vector3(target.global_transform.origin.x-global_transform.origin.x, 0, target.global_transform.origin.z - global_transform.origin.z).normalized()
	
	velocity.x = SPEED * target_vector.x
	velocity.z = SPEED * target_vector.z
	
	#print(str(target.global_transform.origin.x))
	
	
	move_and_slide()
