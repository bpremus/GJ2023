extends Control

@export var showCharacterList: bool = false
@export var showStatsWindow: bool = false
@export var showChatWindow : bool = false

@export var character_window : Control
@export var chatwindow : Control


func showCharacterMenu(show: bool) -> void:
	print("show Character menu: ", show)
	if show:
		character_window.show()
	else:
		character_window.hide()
	pass

func showChatMenu(show: bool) -> void:
	print("show Chat menu: ", show)
	if show:
		chatwindow.show()
	else:
		chatwindow.hide()
	pass

func showStatsMenu(show: bool) -> void:
	print("show Stats menu: ", show)
	pass
