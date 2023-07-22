extends Control

@export var ResponseButton : Control

var _option
@export var _chatLine : Control

func setChatLine(control):
	_chatLine = control

func setReponse(option):
	_option = option
	ResponseButton.text = option.text
	pass

func _on_button_pressed():
	_chatLine.buttonPress(_option)
	pass 
 
