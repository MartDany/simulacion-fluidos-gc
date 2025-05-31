extends Node

# Variable Global de Escena
var current_scene = null

# Funcion - Nodo Listo
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

# Funcion - Cambiar de Escena
func goto_scene(path) -> void:
	get_tree().change_scene(path)
