extends Node2D

const Enemy = preload("res://scenes/enemy.tscn")

const SPAWN_INTERVAL = 4.0
const COLORS = ['amarillo', 'player', 'rojo', 'verde']

var spawn_timer = 0.0

func _process(delta):
	spawn_timer += delta
	if spawn_timer >= SPAWN_INTERVAL:
		spawn_timer = 0
		spawn_enemy()

func spawn_enemy():
	var enemy = Enemy.instantiate()
	var random_color = COLORS[randi() % 4]
	enemy.set_color(random_color)
	add_child(enemy)
