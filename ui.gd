extends Control


@onready var info_label_scene = load("res://info_label.tscn")
@onready var global_storage := GlobalStorage
@export var label_container: Container


func _ready():
	#TODO 完善标签的自动生成
	
	pass


func update_ui(_res_type, _value) -> void:
	pass
