extends Node


@export var ui_mng: Node
@export var furnace_mng: Node

@onready var global_storage: GlobalStorage = GlobalStorage


func _ready():

	pass

func _on_button_pressed() -> void:
	#TODO 产出机制链接其他脚本
	global_storage.AddStorage("Stone",1)
	print("Current stones: " + str(global_storage.GetStorage("Stone")))
	pass
