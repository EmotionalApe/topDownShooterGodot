extends KinematicBody2D

export var speed = 200

onready var raycast = $RayCast2D
onready var crosshair = $Crosshair

func _ready() -> void:
	yield(get_tree(), "idle_frame")
	get_tree().call_group("zombies", "set_player", self)


func _physics_process(delta: float) -> void:
	
	crosshair.position = get_local_mouse_position()
	
	var moveVec = Vector2()
	
	if Input.is_action_pressed("move_up"):
		moveVec.y -= 1
	if Input.is_action_pressed("move_down"):
		moveVec.y += 1
	if Input.is_action_pressed("move_left"):
		moveVec.x -= 1
	if Input.is_action_pressed("move_right"):
		moveVec.x += 1
	
	moveVec = moveVec.normalized()
	move_and_collide(moveVec * speed * delta)

	var VecFromPlayerToMouse = get_global_mouse_position() - global_position
	rotation = atan2(VecFromPlayerToMouse.y, VecFromPlayerToMouse.x)
	
	if Input.is_action_pressed("shoot"):
		var coll = raycast.get_collider()
		if raycast.is_colliding() && coll.has_method("kill"):
			coll.kill()


func kill():
	get_tree().reload_current_scene()

