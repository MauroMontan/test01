
extends Node

export(PackedScene) var mob_scene
var score

func _ready():
	randomize()
	new_game()

func game_over():
	$EnemyTimer.stop()

func new_game():
	$Player.position = $StartPosition.position
	$StartTimer.start()
	score = 0

func _on_EnemyTimer_timeout():
	
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instance()
	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	
	mob_spawn_location.offset = randi()
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

func _on_StartTimer_timeout():
	$EnemyTimer.start()


