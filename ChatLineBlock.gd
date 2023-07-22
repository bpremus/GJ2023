extends PanelContainer
@export var cName : Control
@export var cText : Control
@export var cTexture : Control
@export var debug_tags : bool = true
@export var reponse_container : Control
@export var response_prefab = preload("res://chat_respo_button.tscn")
@export var avatarFolder = "res://Images/avatars/"

var _player
var _character
var _options

func setCharacter(character) -> void:
	_character = character
	cName.text = character.name
	var path = avatarFolder + str(character.id) + ".png"
	cTexture.texture = load(path)
		
func setPlayer(player) -> void:
	_player = player

func setAsPlayerResponse() -> void:
		cName.text = _player.name
		var path = avatarFolder + str(_player.avatarID) + ".png"
		cTexture.texture = load(path)
		
func setAsPlayerOptions(options) -> void:
	cText.text = ""
	_options = options
	for i in range(len(options)):
		var option = options[i]
		var slot = response_prefab.instantiate()
		reponse_container.add_child(slot)
		slot.setReponse(option)
		slot.setChatLine(self)
	pass
	
	setAsPlayerResponse()

func setDialogData(dialog) -> void:
	cText.text = replaceTags(dialog.text)
	if (dialog.player == true):
		setAsPlayerResponse()

func buttonPress(option) -> void:	
	clearPlayerOptions()
	cText.text = option.text
	
	#send notification to Story
	var node = get_node("/root/Main/Story")
	node.conversationOptionPress(_character, option)
	
	
func clearPlayerOptions() :
	var children = reponse_container.get_children()
	for c in children:
		reponse_container.remove_child(c)
		c.queue_free()
	pass
	
func replaceTags(line : String) -> String:
	line = line.replace("{me}", _player.name)
	line = line.replace("{origin}", " origin ")
	line = line.replace("{character}", _character.name)
	#line = line.replace("{faction}", _character.faction)
	return line
	pass

