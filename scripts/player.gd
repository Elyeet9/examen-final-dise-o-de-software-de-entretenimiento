extends CharacterBody2D

const MAX_HP = 3
const SPEED = 300.0

var current_hp = MAX_HP
var color = 'player'

@onready var health_label = get_node("../lblHealth")

func _ready():
	position = Vector2(400, 300)

func _process(delta):
	handle_movement()
	if current_hp <= 0:
		game_over()

func handle_movement():
	var direction = Vector2.ZERO
	
	# Inputs definidos en Input Map
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	
	direction = direction.normalized()
	velocity = direction * SPEED
	move_and_slide()

func heal():
	if current_hp < 5:
		current_hp += 1
	health_label.text = "HP: %d" % current_hp

func take_damage():
	current_hp -= 1
	health_label.text = "HP: %d" % current_hp

func game_over():
	get_tree().change_scene_to_file("res://scenes/gameOver.tscn")
