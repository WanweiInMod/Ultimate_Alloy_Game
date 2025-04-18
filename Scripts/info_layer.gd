# info_layer.gd
extends CanvasLayer

@onready var global_data = GlobalData
@onready var currency_label = $CurrencyLabel

# 初始化
func _ready():

	# 组件显示初始化
	self.visible = true

	# 信号连接
	global_data.connect('resource_update', resources_has_update)

	# 初始标签文本更新
	currency_label.text = 'Stone: ' + '0'

	pass


# 接收新数据，更新标签
func resources_has_update() -> void:
	var stone:int = global_data.get_resource_count(global_data.currencies, global_data.CURRENCIES.STONE)
	currency_label.text = 'Stone: ' + str(stone)
	pass
