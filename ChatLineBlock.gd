extends PanelContainer
@export var label : Control
@export var texture_rect : Control
@export var debug_tags : bool = true
@export var reponse_container : Control
@export var response_prefab = preload("res://chat_response.tscn")

func setText(textLine : String) -> void:
	label.text = textLine


func setLine(line : gcLine) -> void:
	label.text = line.text
	
	if line.response:
		label.text = "Me:\n"
		
		for i in range(len(line.response)):
			var resp = line.response[i]
			addChatResponse(resp)
			#label.text = label.text + "\t > " + resp.text + " #" +resp.gotoLine + "\n"
	pass

func addChatResponse(chatLine : gcResponse):
	var slot = response_prefab.instantiate()
	reponse_container.add_child(slot)
	slot.setLine(chatLine)
	pass
