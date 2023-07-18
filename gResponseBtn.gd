extends MarginContainer

@export var responsebutton : Control
@export var lineController : Control

var _response : gcResponse

func setText(text : String) -> void :
	responsebutton.text = text

func setLine(response : gcResponse) -> void :
	_response = response
	setText(response.text)
	pass

func _on_gui_input(event):
	#if event is InputEventMouseButton and event.is_pressed():
	#not working correctly
	pass 

func _on_button_pressed():
	var node = get_node("/root/Node2D/ChatController")
	node.response_press(_response.gotoLine)
	lineController.replaceChatResponseWithText(_response.text)
	pass 

