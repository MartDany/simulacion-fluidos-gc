extends ColorRect

# Area de Boton
onready var button = get_node("Area2D")
signal selected
export var value: String

func _input(event):
	if event.is_action_pressed("Click"):
		if (button.hover):
			Globals.fluid_select = value
			emit_signal("selected")
			color = Color(0.05,0.85,1,0.5)

func _on_WaterButton_selected():
	color = Color(1,1,1,0.18)

func _on_SlimeButton_selected():
	color = Color(1,1,1,0.18)

func _on_HoneyButton_selected():
	color = Color(1,1,1,0.18)
