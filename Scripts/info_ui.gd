extends Control

# 定义类方便处理更新
class_name InfoUi

# 属性
var target_item: String
var item_icon: Texture2D
var item_data: Node

# 初始化
func _ready() -> void:
	# 类属性
	
	# 子节点属性
	$InfoCount.text = '0'
	return



