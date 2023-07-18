extends MarginContainer

@export var responsebutton : Control

var _response : gcResponse

func setText(text : String) -> void :
	responsebutton.text = text

func setLine(response : gcResponse) -> void :
	_response = response
	setText(response.text)
	pass

func _on_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		print ("ANS: ", _response.gotoLine)
	pass # Replace with function body.
