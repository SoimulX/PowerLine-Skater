extends Node

class_name svg_utils

# SVG DOCUMENT STRUCTURE
# <svg ...> ... </svg>					=> NAMESPACE
# 		<path [or rect etc.] ... />		=> ELEMENT


# fill="#rrggbb" or fill="#rgb" => ELEMENT COLOR

# WHOLE SVG TEXT		=> SOURCE
# PART OF SVG 			=> ELEMENT

# EXPORTING

func element_as_sprite(element):
	var source = _element_to_source(element)
	return source_as_sprite(source)

func source_as_sprite(source):
	var image = Image.new()
	var error = image.load_svg_from_buffer(source.to_utf8_buffer())
	assert(error == OK)
	
	var texture = ImageTexture.new()
	texture.set_image(image)
	
	var node = Sprite2D.new()
	node.texture = texture
	
	return node

# ARTISTIC EDITING
	
func change_color(element: String, color: Color):
	var html_color = color.to_html(false)
	
	var fill_start_index = element.find("#")
	var fill_end_index = element.find('"', fill_start_index) - 1
	var num_chars = fill_end_index - fill_start_index
	
	if fill_start_index == -1 or num_chars not in range(0, 6+1):
		print("Background svg gen path color not in range!")
		return false
	
	var start = fill_start_index + 1
	return element.substr(0, start) + html_color + element.substr(start + num_chars)

# DOCUMENT HANDLER

func load_document(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var source = file.get_as_text()
	file.close()
	return source

func split_into_elements(source):
	var elements = []

	# Define a list of self-closing element types to search for
	var element_types = ["path", "rect"]

	for element_type in element_types:
		# Create a search pattern for the self-closing element
		var pattern = "<" + element_type + " "

		# Find the first occurrence of the element
		var pos = source.find(pattern)
		while pos != -1:
			# Find the end of the self-closing tag
			var end_pos = source.find("/>", pos)
			if end_pos != -1:
				# Include the length of "/>" to capture the whole element
				end_pos += 2
				# Extract the element and add it to the elements list
				var element = source.substr(pos, end_pos - pos)
				elements.append(element)
				# Prepare to search for the next occurrence
				pos = source.find(pattern, end_pos)
			else:
				# If there's no closing tag found, break the loop
				break
	
	#for i in range(elements.size()):
		#elements[i] = _element_to_source(elements[i])
		
	return elements
	
func _element_to_source(element):
	return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1152 648">""" + element + """</svg>"""
