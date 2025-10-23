extends Node2D


# 加载关卡信号
signal level_load(target:String)

var level_node: Node

func _ready() -> void:
	level_node = get_node("Level")
	return

