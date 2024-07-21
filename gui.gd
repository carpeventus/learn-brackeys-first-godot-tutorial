extends CanvasLayer

@onready var score_label: Label = %ScoreLabel

func _ready() -> void:
	GameManager.score_changed.connect(_update_score)
	_update_score()
	
func _update_score() -> void:
	score_label.text = str(GameManager.score)
	
