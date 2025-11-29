extends Node
class_name InputHandler
var curr_input = InputGetter.new()
func handleInput() -> void:
	curr_input = InputGetter.new()
	curr_input.get_input()
	
	#d for input_value in curr_input.input_actions:
		#print(input_value)
	pass
