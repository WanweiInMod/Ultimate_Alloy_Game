# main.gd
extends Node2D

@onready var global_data = GlobalData 
@onready var mining_button = $CenterContainer/MiningClicker
@onready var furnace_button = $CenterContainer/FurnaceButton
@onready var miner_button = $CenterContainer/MinerButton

@export var test_bonus:int = 1


# 初始化
func _ready():

	# 按钮设置为隐藏
	furnace_button.visible = false
	miner_button.visible = false

	# 信号连接
	global_data.connect('resource_update',enabled_check)
	global_data.connect('stage_update',stage_check)

	# 检查每一个阶段的初始状态
	for stage_key in global_data.stages.keys():
		stage_check(stage_key)
		pass
	
	pass


# 挖矿按钮点击事件
func mining_click():
	global_data.add_resource_count(global_data.currencies, global_data.CURRENCIES.STONE, 1 * test_bonus)
	pass


# 按钮阶段检查
func stage_check(stage_key):
	if global_data.get_resource_count(global_data.stages, stage_key) >= 1:
		match stage_key:
			global_data.FACILITIES.FURNACE : 
				furnace_button.visible = true
			global_data.FACILITIES.MINER :
				miner_button.visible = true
	pass


# 熔炉按钮点击事件
func furnace_click():

	var current_stage = global_data.get_resource_count(global_data.stages, global_data.FACILITIES.FURNACE)
	var expends:Dictionary = global_data.facility_prices[global_data.FACILITIES.FURNACE][current_stage]
	for expend in expends.keys():
		global_data.add_resource_count(global_data.currencies, expend, -expends[expend]) 
		pass
	
	global_data.add_resource_count(global_data.facilities, global_data.FACILITIES.FURNACE, 1)
	button_text_update(global_data.FACILITIES.FURNACE)
	pass


# 按钮状态检查
func enabled_check():
	for facility_key in global_data.facilities.keys():
		var current_stage = global_data.get_resource_count(global_data.stages, facility_key)
		match facility_key:
			global_data.FACILITIES.FURNACE: 
				furnace_button.disabled = enable_check_condition(facility_key, current_stage)
			global_data.FACILITIES.MINER:
				miner_button.disabled = enable_check_condition(facility_key,current_stage)
		pass
	pass


# 按钮状态更新条件判断函数
func enable_check_condition(facility_key, stage:int) -> bool:

	# 判断是否达到设施数量上限
	var amount_limit = global_data.stage_limit_facilities[facility_key][stage]
	var current_count = global_data.get_resource_count(global_data.facilities, facility_key)
	if current_count >= amount_limit: return true

	# 判断是否满足所有购买价格条件
	var price_dict = global_data.facility_prices.get(facility_key,{}).get(stage,{})
	for currency_key in price_dict:
		if global_data.get_resource_count(global_data.currencies, currency_key) < price_dict[currency_key]:
			return true
	pass

	# 以上皆满足
	return false


# 按钮文本更新
func button_text_update(facility_key):

	var amount:int = global_data.get_resource_count(global_data.facilities, facility_key)

	match facility_key:
		global_data.FACILITIES.FURNACE: furnace_button.text = '(%d) Furnace \nCost: stone * 10' % amount

	pass
