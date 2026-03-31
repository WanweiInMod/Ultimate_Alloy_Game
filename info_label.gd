extends HBoxContainer


func _ready() -> void:
	$Label.text = "0"
	pass


func update_text(count: int) -> void:
	$Label.text = str(count)
	pass
