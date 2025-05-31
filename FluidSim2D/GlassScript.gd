extends RigidBody2D

func _process(_delta):
	if Input.is_key_pressed(KEY_LEFT):
		rotation_degrees -= 1
	elif Input.is_key_pressed(KEY_RIGHT):
		rotation_degrees += 1
