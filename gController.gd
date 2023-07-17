extends Control

#keep stats on a game progress
@export var characters_on_screen : Array
@export var seelcted_character : String
@export var tags : Array
@export var curret_scene : int = 1
@export var showCharacterList: bool = false
@export var showStatsWindow: bool = false
@export var showChatWindow : bool = false

@onready var ui_controller = $"../UIController"


func _ready():
	initGame()
	pass # Replace with function body.

# set everyghing so the game can start
func initGame() -> void:
	print("init game")
	ui_controller.showCharacterMenu(true)
	ui_controller.showChatMenu(true)
	ui_controller.showStatsMenu(false)
	#add log window
	
	laodStory()
	nextChapter()

func endChat() -> void:
	pass
	
func endChapter() -> void:
	pass

#read game flow 
func laodStory() -> void :
	pass
	
func nextChapter() -> void :
	pass

# next game turn
func nexttGameTurn() -> void :
	pass 

func loadChat() -> void :
	pass

func loadStats() -> void :
	pass



