# global_data.gd
extends Node

signal resource_update()
signal stage_update(stage_key:String)

var currencies:Dictionary = {
	CURRENCIES.STONE: 0 ,
	CURRENCIES.INCOME: 0 ,
	CURRENCIES.COPPER: 0 ,
	CURRENCIES.IRON: 0 ,
	CURRENCIES.SILVER: 0 ,
	CURRENCIES.GOLD: 0 ,
} # 储存货币类资源


var facilities:Dictionary = {
	FACILITIES.FURNACE: 0 ,
	FACILITIES.MINER: 0 ,
} # 储存当前设施总量


var stages:Dictionary = {
	FACILITIES.MINING: 1 ,
	FACILITIES.FURNACE: 0 ,
	FACILITIES.MINER: 0 ,
} # 存储当前阶段数据


const stage_limit_facilities:Dictionary = {
	FACILITIES.FURNACE : [0, 10, 20] ,
	FACILITIES.MINER : [0, 10, 20] ,
} # 存储每个阶段的设施数上限


const facility_prices:Dictionary = {
	FACILITIES.FURNACE : 
		{
			1 : {CURRENCIES.STONE: 10, } ,
			2 : {CURRENCIES.STONE: 10, CURRENCIES.INCOME: 300} 
		} ,
	FACILITIES.MINER :
		{
			1 : {CURRENCIES.INCOME: 150, } ,
			2 : {CURRENCIES.INCOME: 450, } ,
		} ,
} # 存储每个阶段的设施价格


# 词典字符串常量词典
enum CURRENCIES {
	STONE,
	INCOME,
	COPPER,
	IRON,
	SILVER,
	GOLD,
} # 货币资源


enum FACILITIES {
	MINING,
	FURNACE,
	MINER,
} # 设施（包括部分阶段命名）


const FACILITIES_NAME:Dictionary = {
	FACILITIES.FURNACE : 'Furnace' ,
	FACILITIES.MINER : 'Miner' ,
} # 存储枚举命名字符串


# 初始化
func _ready():
	self.connect('resource_update', resource_update_check)
	pass


# 获取资源数据
func get_resource_count(from_dict:Dictionary, resource_key) -> int:
	
	return from_dict[resource_key]


# 修改（增加）资源数据
func add_resource_count(from_dict:Dictionary, resource_key, value:int) -> void:

	from_dict[resource_key] += value
	resource_update.emit()
	pass



# 新增资源数据项
func set_resource_count(from_dict:Dictionary, resource_key, default_value:int) -> void:

	from_dict[resource_key] = default_value
	resource_update.emit()
	pass


# 资源更新后条件判定
func resource_update_check():
	
	for stage_key in stages.keys():

		var current_stage = stages[stage_key]

		if levelup_condition_check(stage_key,current_stage):

			stages[stage_key] += 1
			stage_update.emit(stage_key)

			var stage_name:StringName = FACILITIES_NAME[stage_key]
			print(stage_name + ' has level up!')

			pass
		
		pass

	pass


# 阶段升阶的判定函数
func levelup_condition_check(stage_key, current_stage:int) -> bool :

	# 每一阶的条件代表提升到下一阶的要求
	# 最高阶默认false锁定

	match stage_key:
		FACILITIES.MINING:
			match current_stage:
				0 : return true
				_ : return false

		FACILITIES.FURNACE:
			match current_stage:
				0 : return currencies.get(CURRENCIES.STONE) >= 10
				1 : return facilities.get(FACILITIES.FURNACE) >= 10
				_ : return false

		FACILITIES.MINER:
			match current_stage:
				0 : return currencies.get(CURRENCIES.INCOME) > 0
				_ : return false

		_ : return false
