extends Node
class_name InputGetter

var input_actions : Array[String]

var input_direction : Vector2

func get_input() -> void:
	input_actions.append("idle")
	input_direction = Input.get_vector("left", "right", "forward", "backward")
	if input_direction != Vector2.ZERO:
		input_actions.append("run")
		if Input.is_action_pressed("sprint"):
			input_actions.append("sprint")
			
