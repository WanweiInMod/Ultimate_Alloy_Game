extends Node2D

# 按钮触发信号
signal activate(target:String)

# 

# 点击按钮时，石头+1
func _on_button_mine_pressed() -> void:
	activate.emit('mine')
	return 


func _on_button_furnace_pressed() -> void:
	activate.emit('furnace')
	return
