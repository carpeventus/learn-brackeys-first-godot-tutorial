extends CharacterBody2D

@onready var timer: Timer = $HurtArea/Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var hurt_area: Area2D = $HurtArea

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

var direction: float = 0

func _ready() -> void:
	hurt_area.body_entered.connect(_on_hurt_body_entered) 
	timer.timeout.connect(_on_timer_timeout)

func _on_hurt_body_entered(body : Node2D) -> void:
	print("You are dead!")
	collision_shape_2d.set_deferred("disabled", true)
	Engine.time_scale = 0.6
	timer.start()
	

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if not is_zero_approx(direction) :
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("move_left", "move_right")
	if not is_zero_approx(direction) :
		sprite_2d.scale = Vector2(direction, 1)
	
	update_animation()

func update_animation() -> void:
	if not is_on_floor():
		animation_player.play("jump")
	else:
		if is_zero_approx(direction): 
			animation_player.play("idle")
		else:
			animation_player.play("run")
