extends CharacterBody2D

@export var speed: int = 60

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight

var direction: Vector2i = Vector2i.RIGHT

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func _process(delta: float) -> void:
	if ray_cast_left.is_colliding():
		direction = Vector2i.RIGHT
		animated_sprite_2d.flip_h = false
	elif ray_cast_right.is_colliding():
		direction = Vector2i.LEFT
		animated_sprite_2d.flip_h = true
	position += direction * speed * delta
