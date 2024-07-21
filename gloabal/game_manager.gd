extends Node

signal score_changed

var score: int:
	set(value): 
		score = value
		score_changed.emit()

func add_score() -> void:
	score += 1

func clear_score() -> void:
	score = 0
