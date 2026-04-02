extends HBoxContainer
class_name InfoLabel


@onready var label := $Label


func _ready() -> void:
	label.text = "0"
	pass


func update_text(count: int) -> void:
	label.text = str(count)
	pass
