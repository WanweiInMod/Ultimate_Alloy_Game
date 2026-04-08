extends Node


@export var mining_button: Button

@onready var global_storage := GlobalStorage


func _ready():
    mining_button.pressed.connect(_on_button_pressed)
    pass

func _on_button_pressed() -> void:
    #TODO 产出机制链接其他脚本
    global_storage.add_storage("Stone",1)
    pass
