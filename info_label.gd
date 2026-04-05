extends HBoxContainer
class_name InfoLabel


@onready var text_label := $Label
@onready var global_storage := GlobalStorage
var storage_item := ""


func _ready() -> void:
	text_label.text = "0"
	global_storage.connect("StorageUpdated",update_text)
	pass


func update_text(item_type: StringName, _count: float) -> void:
	if item_type != storage_item:
		return
	if !visible:
		show()
		pass
	text_label.text = str(int(global_storage.get_storage(storage_item)))
	pass
