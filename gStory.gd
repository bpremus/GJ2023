extends Control

#story document
const storyText : String = "res://story.txt"

func _ready():
	var story = loadStory(storyText)
	var block = getStorySegment(2, story)
	getDialogSegment(block)

func loadChapter(index: int) -> void:
	pass


func loadStory(story_path : String ) -> String:
	var file = FileAccess.open(story_path, FileAccess.READ)
	var content = file.get_as_text()
	return content
	
func isStart(line : String) -> bool:
	if line.find("start :=  ") > -1 :
		return true
	return false
	
func isEnd(line : String) -> bool:
	if line.find("end :=  ") > -1 :
		return true
	return false
	
func isGoTo(line : String) -> bool:
	if line.find("goto :=  ") > -1 :
		return true
	return false
		
func isOption(line : String) -> bool:
	if line.find("option :=") > -1 :
		return true
	return false
			
func getDialogSegment(storyBlock: Array):
	for i in range(len(storyBlock)):
		var line = storyBlock[i]
		if isStart(line) : 
			print("start")
		
'''
	read from the start till end 
	add to array
	must return with response or end
	
	each reponse option is new dialog in array, response holds pointer to next dialog in array	

'''	
	

func getStorySegment(index: int, content: String):
	var block = content.split('\n')
	var found = false
	var newBlock = []
	for line in block:
		if line.find("scene := ") > -1 :
			if index == int(line.split(":=")[1]):
				found = true
			else:
				found = false
			continue
		if found: 
			newBlock.append(line)	
		
	return newBlock
