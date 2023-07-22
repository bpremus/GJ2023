extends Resource
class_name characterStats

@export var _id : int 
@export var _name : String 
@export var _age : int 
@export var _texture : Texture

#links
@export var _location_id : int 

#stats
@export var _tags : Array
@export var _likness : int 

#func
func addTag(tag : String) -> void:
	pass
	
func hasTag(tag : String) -> bool:
	return false
