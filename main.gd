extends Node


@export var ui_mng: Node
@export var furnace_mng: Node

@onready var global_storage: GlobalStorage = GlobalStorage


func _ready():

	pass

func _on_button_pressed() -> void:

	global_storage.AddStorage("Stone",1)
	pass
