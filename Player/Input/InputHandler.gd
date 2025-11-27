extends Node
class_name InputHandler

func handleInput() -> void:
	var curr_input = InputGetter.new()
	curr_input.get_input()
	
	for input_value in curr_input.input_actions:
		print(input_value)
	pass
