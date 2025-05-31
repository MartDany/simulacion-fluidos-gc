extends Node2D

func _ready():
	Engine.iterations_per_second = 120
	
	if Globals.fluid_select == "water":	
		var node1 = get_node("SlimeColor")
		var node2 = get_node("HoneyColor")
		node1.queue_free()
		node2.queue_free()
	elif Globals.fluid_select == "slime":
		var node1 = get_node("WaterColor")
		var node2 = get_node("HoneyColor")
		node1.queue_free()
		node2.queue_free()
	elif Globals.fluid_select == "honey":
		var node1 = get_node("SlimeColor")
		var node2 = get_node("WaterColor")
		node1.queue_free()
		node2.queue_free()
