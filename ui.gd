extends Control


@onready var info_label_scene = load("res://info_label.tscn")


func update_ui() -> void:
	$TopPanel/InfoContainer/InfoLabel.update_text(GlobalStorage.Stones)
	pass