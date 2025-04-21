extends Node

@onready var global_data = GlobalData
@onready var furnace_button = self

# 生产速度
var production_interval:float = 10.0
@export var debug_interval:float = 0.0

# 计时器
var prod_timer:Timer

# 本次生产的数量
var prod_amount:int = 0


# 初始化
func _ready():

	# 按钮购买信号更新
	furnace_button.pressed.connect(_on_furnace_button_pressed)

	# 计时器初始化
	prod_timer = Timer.new()
	prod_timer.wait_time = production_interval - debug_interval
	prod_timer.timeout.connect(_on_timer_timeout)
	add_child(prod_timer)

	if global_data.get_resource_count(global_data.facilities,global_data.FACILITIES.FURNACE) != 0:
		produce_resource()
		disconnect_furnace_button()
		pass

	pass


# 购买后触发生产
func _on_furnace_button_pressed():
	if prod_timer.is_stopped():
		produce_resource()
		disconnect_furnace_button()
		pass
	pass


# 熔炉生产计时
func _on_timer_timeout():
	produce_resource()
	pass


# 生产执行
func produce_resource():

	# 遍历熔炉生产
	for prod in range(0,prod_amount):
		generate_resource()
		pass

	# 获得当前设施数量并扣除相应材料，如材料不足则按消耗材料计算
	var current_stone = global_data.get_resource_count(global_data.currencies,global_data.CURRENCIES.STONE)
	var current_furnace = global_data.get_resource_count(global_data.facilities,global_data.FACILITIES.FURNACE)
	prod_amount = min(current_stone,current_furnace)
	global_data.add_resource_count(global_data.currencies, global_data.CURRENCIES.STONE, -prod_amount)

	#启动计时器
	prod_timer.start()

	pass


# 产物生成处理
func generate_resource():
	# TODO 处理资源增加机制

	# FIXME 临时测试用，机能完全后删除
	global_data.add_resource_count(global_data.currencies, global_data.CURRENCIES.COPPER, 1)
	print('Generate 1 Copper')

	pass


# 产率概率计算
func get_production_probability():
	# TODO 处理概率字典
	pass


# 按钮信号断开函数
func disconnect_furnace_button():
	if furnace_button.pressed.is_connected(_on_furnace_button_pressed):
		furnace_button.pressed.disconnect(_on_furnace_button_pressed)
		pass
	pass
