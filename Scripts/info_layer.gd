# info_layer.gd
extends CanvasLayer

@onready var global_data = GlobalData
@onready var currency_label = $CurrencyLabel
@onready var trade_dialog_scene = load('res://Scenes/trading_dialog.tscn')

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

	# TODO 修改标签显示处理
	var stone:int = global_data.get_resource_count(global_data.currencies, global_data.CURRENCIES.STONE)
	currency_label.text = 'Stone: ' + str(stone)
	pass


# 交易按钮信号连接
func _on_trade_entrance_pressed():

	# TODO 实例化交易对话框面板
	# FIXME 处理生成逻辑，保证只生成一个对话框
	var trade_dialog = trade_dialog_scene.instantiate()
	add_child(trade_dialog)

	pass 
