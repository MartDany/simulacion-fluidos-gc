extends ColorRect

# Area de Boton
onready var button = get_node("Area2D")
export var path: String

func _input(event):
	if event.is_action_pressed("Click"):
		if (button.hover):
			SceneSwitcher.goto_scene(path)
