extends Area2D


const SPEED = 200.0

var direction = Vector2.ZERO
var color = 'verde'

func _ready() -> void:
	spawn()

func _process(delta):
	position += direction * SPEED * delta
	
	# Borrar si se va de la pantalla
	if not get_viewport_rect().has_point(position):
		queue_free()

func spawn():
	var random_side = randi() % 4
	var spawn_position = Vector2.ZERO
	
	# Inicializar su posicion y direccion
	match random_side:
		0: 
			spawn_position = Vector2(randf_range(0, 800), 0)  # Arriba
			direction.y = 1
		1: 
			spawn_position = Vector2(0, randf_range(0, 600))  # Izquierda
			direction.x = 1
		2: 
			spawn_position = Vector2(randf_range(0, 800), 600)  # Abajo
			direction.y = -1
		3: 
			spawn_position = Vector2(800, randf_range(0, 600))  # Derecha
			direction.x = -1
	
	position = spawn_position

func set_color(new_color):
	# Mandar un color y cargar la textura y variable
	color = new_color
	match color:
		"amarillo":
			$spriteEnemy.texture = preload("res://assets/amarillo.png")
		"player":
			$spriteEnemy.texture = preload("res://assets/player.png")
		"rojo":
			$spriteEnemy.texture = preload("res://assets/rojo.png")
		"verde":
			$spriteEnemy.texture = preload("res://assets/verde.png")

# Signal para detectar al player. Ambos estan en el mismo layer y mask
func _on_body_entered(body: Node2D) -> void:
	if body.color == color:
		body.heal()
	else:
		body.take_damage()
	queue_free()
