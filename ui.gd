extends Control


@onready var info_label_scene = load("res://info_label.tscn")
@onready var global_storage: Node = GlobalStorage


func _ready():
	global_storage.connect("StorageUpdated",update_ui)
	pass


func update_ui(_res_type, _value) -> void:
	$TopPanel/InfoContainer/InfoLabel.update_text(global_storage.GetStorage("Stone"))
	pass