extends Node


@onready var game_ui = $UI

var count_of_res = 0

func _on_button_pressed() -> void:
	count_of_res += 1
	game_ui.update_ui(count_of_res)
	pass # Replace with function body.
