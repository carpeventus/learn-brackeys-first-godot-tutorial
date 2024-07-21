extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	audio_stream_player_2d.finished.connect(queue_free)

func _on_body_entered(_body: Node2D) -> void:
	GameManager.add_score()
	audio_stream_player_2d.play()
