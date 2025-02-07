extends CharacterBody2D

var awareness = 0
var aggression = 0
var fear = 0
var health = 1

@onready var player = $"../Player/CharacterBody2D"
@onready var nav = $NavigationAgent2D

var speed = 60
var accel = 5

func _physics_process(delta: float) -> void:
	
	var direction = Vector3()
	
	nav.target_position = player.global_position
	print(nav.target_position)
	#nav.target_position = get_global_mouse_position()
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	rotation = direction.angle()
	
	
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	if velocity.length() != 0:
		$AnimatedSprite2D.play("swim")
	else:
		$AnimatedSprite2D.stop()
	
	move_and_slide()
