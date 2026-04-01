extends Node


@export var game_ui: Control

@onready var global_storage: Node = GlobalStorage

func _on_button_pressed() -> void:

	global_storage.Stones += 1
	game_ui.update_ui(global_storage.Stones)
	pass # Replace with function body.
