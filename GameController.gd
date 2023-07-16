extends Control

const characterXML : String = "res://characters.txt"
const storyText : String = "res://story.txt"

# Called when the node enters the scene tree for the first time.
func _ready():
	testLines()


func testLines() -> void:
	# read string story
	var story = loadStory(storyText)
	# get block
	var sceneBlock = getSceneArrayBlock(2,story)
	
	var range = 10
	for x in range(range):
		var line = nextLine(x, sceneBlock)

		if len(line):
			if (line[0] == "option"):
				var arr = getAvailableAnswers(line)
				
				var idx = getOptionLine("goto2", sceneBlock)
				print (" > selected 2")
				line = nextLine(idx+1, sceneBlock)
				formattedLine(line)
				line = nextLine(idx+2, sceneBlock)
				formattedLine(line)
				break
				#var gototag = line[1][1]
				#var idx = getOptionLine(gototag, sceneBlock)
				#print(idx, " > ", line)
				#break
			else:
				formattedLine(line)
		
func formattedLine(line: Array) -> void:
	print (line[0] , " > ", line[1][0] )	
			
func getAvailableAnswers(line : Array) -> Array:
	for x in len(line):
		var opt = line[x]
		var a = []
		if (typeof(opt) == typeof(a)):
			print (opt[1] , " > ", opt[0] )
		
	return []
			
func loadStory(story_path : String ) -> String:
	var file = FileAccess.open(story_path, FileAccess.READ)
	var content = file.get_as_text()
	return content


func getSceneArrayBlock(index: int, story : String ) -> Array:
	var block = story.split('\n')
	var arrayBlock = []
	var found = 0
	for line in block:
		if found == 1:
			var x = line.find("scene := ")
			if x > -1:
				found = 0
			else:
				# clean before passing it out
				var j = line.split(":=")
				var parts = []
				for part in j:
					parts.append(part.strip_edges())
				arrayBlock.append(parts)
			
		var x = line.find("scene := " + str(index))
		if x > -1:
			found = 1
	return arrayBlock

#no longer needed
func getSceneBlock(index: int, story : String ) -> String:
	var sceneBlock = ""
	var block = story.split('\n');
	var found = 0
	
	for line in block:
		line = line.strip_edges()
		if found == 1:
			var x = line.find("scene := ")
			if x > -1:
				found = 0
			else:
				sceneBlock = sceneBlock + line + "\n"
			
		var x = line.find("scene := " + str(index))
		if x > -1:
			found = 1

	return sceneBlock

func continueSceneBlock(index: int, story : String) -> String:
			
	return ""
	

func getOptionLine(tag: String, storyBlock : Array) -> int:
	for i in range(len(storyBlock)):
		if (len(storyBlock[i])):
			if (storyBlock[i][0] == "goto"):
				if "goto"+storyBlock[i][1] == tag:
					return i
	return -1

func nextLine(index : int , storyBlock : Array) -> Array:
	
	var output = []
	var isOption = false
	for i in range(len(storyBlock)):	
		if (i == index):
			if (storyBlock[i][0] == ""):
				return output
			# if its message return it
			# if its option, collect all options and return them with goto statements
			# if end return end
			
			if (len(storyBlock[i]) == 1):
				#this is a tag
				continue
			
			
			if (storyBlock[i][0] == "option"):
				output.append(storyBlock[i][0])
				output.append([storyBlock[i][1], storyBlock[i][2]])
				#print(storyBlock[i])
				index += 1
				isOption = true
				
			else:
				if (isOption == false):
					output.append(storyBlock[i][0])
					output.append([storyBlock[i][1]])

	return output
	
	

func printChat(story : String) :
	var chat = ""
	var block = story.split('\n')
	var i = 0
	for line in block:
		var x = line.split(":=")
		i += 1
		if (x[0] == "option"):
			# stopping at option
			break	
		if (len(x) == 2):
			say(x[0], x[1])
		
			
func say(character: String, message : String) -> void :
	print(character.strip_edges() + " : " + message.strip_edges())
