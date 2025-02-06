extends CharacterBody2D

@export var move_speed: float = 200.0  # Max movement speed
@export var acceleration: float = 1000.0  # How fast the player speeds up
@export var deceleration: float = 100.0  # Water resistance (slows movement)
@export var gravity: float = 9.8  # Not used much underwater but can simulate sinking

# Buoyancy-related stats
var weight: float = 1
var bcd_capacity: float = 1
var bcd_inflation: float = 1
var buoyancy: float = 0  
var vertical_speed: float = 0  

# Movement input & momentum
var velocity_input: Vector2 = Vector2.ZERO
var momentum: Vector2 = Vector2.ZERO  # Store momentum

@onready var hud = get_tree().get_first_node_in_group("HUD")

func _physics_process(delta):
	# Inflate/Deflate BCD
	if Input.is_action_just_pressed("inflate_bcd"):
		inflate_bcd(0.1)
	if Input.is_action_just_pressed("deflate_bcd"):
		deflate_bcd(0.1)

	# Buoyancy Calculation
	buoyancy = (bcd_inflation * bcd_capacity) - weight
	if buoyancy > 0:
		vertical_speed = -abs(buoyancy) * move_speed * 0.5  
	elif buoyancy < 0:
		vertical_speed = abs(buoyancy) * move_speed * 0.5  
	else:
		vertical_speed = 0  

	# Get movement input
	velocity_input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity_input.y = vertical_speed * delta  

	# Apply acceleration when moving
	if velocity_input.length() > 0:
		momentum += velocity_input * acceleration * delta  # Speed up
		momentum = momentum.limit_length(move_speed)  # Cap max speed
	else:
		# Apply deceleration when no input
		momentum = momentum.lerp(Vector2.ZERO, deceleration * delta)

	# Apply movement
	velocity = momentum
	move_and_slide()

func inflate_bcd(amount: float):
	"""Increase BCD inflation"""
	bcd_inflation = clamp(bcd_inflation + amount, 0, 10)
	if hud:
		hud.update_weight_and_bcd()

func deflate_bcd(amount: float):
	"""Decrease BCD inflation"""
	bcd_inflation = clamp(bcd_inflation - amount, 0, 10)
	if hud:
		hud.update_weight_and_bcd()
