extends CharacterBody2D

@export var awareness: float = 0.6
@export var aggression = 0
@export var fear = 0
@export var health = 1

var max_detection = 500
var detection_range = max_detection * awareness

@onready var player = $"../Player/CharacterBody2D"
@onready var nav = $NavigationAgent2D

@export var speed = 40
@export var accel = 5

func _physics_process(delta: float) -> void:
	
	var direction = Vector3()
	
	nav.target_position = player.global_position
	print("Distance to player: ", nav.distance_to_target())
	
	if nav.distance_to_target() <= detection_range:
		direction = nav.get_next_path_position() - global_position
		direction = direction.normalized()
		
		velocity = velocity.lerp(direction * speed, accel * delta)
		rotation = velocity.angle()
	
	if velocity.length() != 0:
		$AnimatedSprite2D.play("swim")
	else:
		$AnimatedSprite2D.stop()
	
	move_and_slide()
