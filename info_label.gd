extends HBoxContainer


@onready var text_label := $Label
var storage_item := "Stone"
var is_disabled := false


func _ready() -> void:
	text_label.text = "0"
	pass


func update_text(count: int) -> void:
	text_label.text = str(count)
	pass
