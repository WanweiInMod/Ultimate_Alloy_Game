extends Node2D

# 产出资源信号
signal produce( item_type:String, amount:int )

# 全局脚本连接

# 石头产速
var produce_item_stone : int = 1

# 点击按钮时，石头+1
func _on_button_mine_pressed() -> void:
	produce.emit('stone', produce_item_stone)
	print("Mined 1 stone.")
	return 
