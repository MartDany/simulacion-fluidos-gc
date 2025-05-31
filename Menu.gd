extends Node2D

# Variables de Control
func _ready():
	Engine.set_target_fps(60)
	Globals.fluid_select = "water"
