extends Node

# 按钮触发信号
signal activate(target:String)

func _ready() -> void:
	var game_manager : Node = get_tree().get_root().get_node("GameManager")
	activate.connect(game_manager.OnActivate)
	return

# 采矿按钮
func _on_button_mine_pressed() -> void:
	activate.emit('mine')
	return 

# 熔炉购买按钮
func _on_button_furnace_pressed() -> void:
	activate.emit('furnace')
	return

# 矿工招募按钮
func _on_button_miner_pressed() -> void:

	return