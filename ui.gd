extends Control


@onready var info_label_scene = load("res://info_label.tscn")
@onready var global_storage: GlobalStorage = GlobalStorage
@export var label_container: Container


func _ready():
	#TODO 完善标签的自动生成
	for item in global_storage.Storage.keys:
		print(item)
		pass
	pass


func update_ui(_res_type, _value) -> void:
	pass
