extends Node


signal storage_upd

@export var ui_mng: Node
@export var furnace_mng: Node

@onready var global_storage: Node = GlobalStorage


func _ready():
	storage_upd.connect(_on_ui_update)
	storage_upd.connect(storage_check)
	pass

func _on_button_pressed() -> void:

	global_storage.Stones += 1
	storage_upd.emit()
	pass

func _on_ui_update():
	if ui_mng.has_method("update_ui"):
		ui_mng.update_ui()
	else: push_error("ui haven't connect to signal method") 
	pass

func storage_check():
	if furnace_mng.has_method("storage_check"):
		furnace_mng.storage_check()
	else: push_error("ui haven't connect to signal method") 
	pass
