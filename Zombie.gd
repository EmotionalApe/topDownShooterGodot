extends KinematicBody2D

const moveSpeed = 100

onready var raycast = $RayCast2D

var player = null

func _ready() -> void:
	add_to_group("zombies")
	

func _physics_process(delta: float) -> void:
	if player == null:
		return
	
	var vectorToPlayer = player.global_position - global_position
	vectorToPlayer = vectorToPlayer.normalized()
	
	rotation = atan2(vectorToPlayer.y, vectorToPlayer.x)
	move_and_collide(vectorToPlayer * moveSpeed * delta)
	
	
	
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			coll.kill()

func set_player (p):
	player = p

func kill():
	queue_free()
