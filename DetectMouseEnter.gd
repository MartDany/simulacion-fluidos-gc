extends Area2D

# Variable de Estado
var hover = false

func _on_Area2D_mouse_entered():
	hover = true

func _on_Area2D_mouse_exited():
	hover = false
