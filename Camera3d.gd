extends Camera3D


@export var follow_target: Node3D
@export var follow_speed := 5.0
@export var offset := Vector3(0,12.5,12.5)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(str(follow_target.global_transform.origin) + "    " + str(transform.origin))
	if not follow_target:
		return
		
	transform.origin = transform.origin.lerp(offset+follow_target.global_transform.origin, delta*follow_speed)
	pass
