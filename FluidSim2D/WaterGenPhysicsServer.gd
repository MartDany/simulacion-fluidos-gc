extends Node2D

# Variables de Simulacion
export(Texture) var particle_texture: Texture;
export var max_water_particles = 1000
export var spawn_time = 3.0
var current_particle_count = 0
var water_particles = []
var spawn_timer = 0

# Funcion - Crear Particula
func create_particle(friction, mass, damp, grav):
	
	# Sistema Fisico y Renderizador
	var ps = Physics2DServer
	var vs = VisualServer
	
	# Ajustar Coordenadas de Particula
	var trans = global_transform 
	trans.origin += Vector2(rand_range(-10,10),rand_range(-10,10))
	
	# Agregar Particula al Sistema Fisico
	var water_col = ps.body_create()
	ps.body_set_mode(water_col,Physics2DServer.BODY_MODE_RIGID)
	ps.body_set_space(water_col,get_world_2d().space)
	
	# Definir Propiedades Fisicas
	var shape = ps.circle_shape_create()
	ps.shape_set_data(shape,8)
	ps.body_add_shape(water_col,shape,Transform2D.IDENTITY)
	ps.body_set_collision_layer(water_col,1)
	ps.body_set_collision_mask(water_col,1)
	ps.body_set_param(water_col,Physics2DServer.BODY_PARAM_FRICTION,friction)
	ps.body_set_param(water_col,Physics2DServer.BODY_PARAM_MASS,mass)
	ps.body_set_param(water_col,Physics2DServer.BODY_PARAM_BOUNCE,0)
	ps.body_set_param(water_col,Physics2DServer.BODY_PARAM_LINEAR_DAMP,damp)
	ps.body_set_param(water_col,Physics2DServer.BODY_PARAM_GRAVITY_SCALE,grav)
	ps.body_set_state(water_col,PhysicsServer.BODY_STATE_TRANSFORM,trans)
	
	# Agregar Particula al Renderizador
	var water_particle = vs.canvas_item_create()
	vs.canvas_item_set_parent(water_particle, get_canvas_item())
	vs.canvas_item_set_transform(water_particle,trans)
	
	# Definir Aspecto de Particula
	var rect = Rect2()
	rect.position = Vector2(-8,-8)
	rect.size = particle_texture.get_size()/2
	vs.canvas_item_add_texture_rect(water_particle,rect,particle_texture)
	vs.canvas_item_set_self_modulate(water_particle,Color("ff00ff"))
	
	# Agregar al Arreglo
	water_particles.append([water_col,water_particle])

# Funcion - Actualizacion de Motor Fisico
func _physics_process(_delta):
	spawn_timer -= 1
	
	# Actualizar los Graficos de Particula sobre el Cuerpo Fisico
	for col in water_particles:
		var trans = Physics2DServer.body_get_state(col[0],Physics2DServer.BODY_STATE_TRANSFORM)
		trans.origin = trans.origin - global_position
		VisualServer.canvas_item_set_transform(col[1],trans)
		
		# Eliminar Particulas al Salir de la Escena
		if trans.origin.y > 1500:
			Physics2DServer.free_rid(col[0])
			VisualServer.free_rid(col[1])
			water_particles.erase(col)
			Globals.total_water_particles -=1

# Funcion - Crear Particulas con Barra Espaciadora
func _process(_delta):
	if Input.is_key_pressed(KEY_SPACE):
		
		# Agregar Particula hasta Alacanzar Limite
		if spawn_timer < 0 and current_particle_count < max_water_particles:
			if Globals.fluid_select == "water":	
				create_particle(0.1, 0.05, 0.0, 6.0)
			elif Globals.fluid_select == "slime":
				create_particle(15, 0.05, 0.5, 6.0)
			elif Globals.fluid_select == "honey":
				create_particle(40, 0.05, 1.0, 6.0)
			
			current_particle_count += 1
			Globals.total_water_particles += 1
			spawn_timer = spawn_time
