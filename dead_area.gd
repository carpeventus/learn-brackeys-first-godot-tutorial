extends Area2D

@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0 
	get_tree().reload_current_scene()
	


func _on_body_entered(_body: Node2D) -> void:
	print("You are dead!")
	Engine.time_scale = 0.4
	timer.start()
