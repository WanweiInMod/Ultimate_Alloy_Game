# 数据基类
class BaseData: 
	var key: String
	var name: String
	var description: String
	
# 物品库存类
class Item:
	extends BaseData
	enum Sorts { RESOURCE, MODULE, TREASURE }
	var sort: Sorts
	var amount: float
	
	func _init() -> void:
		sort = Sorts.RESOURCE
	
	func _to_string() -> String:
		if sort == Sorts.TREASURE:
			return "%s, accurate: %f" % [key,amount]
		else :
			return "%s, amount: %f" % [key,amount]
			
	func parse_sort(sort_str:String) -> Sorts:
		match sort_str.to_lower():
			"resource": return Sorts.RESOURCE
			'module': return Sorts.MODULE
			'treasure': return Sorts.TREASURE
			_: return Sorts.RESOURCE	

# 设施类
class Facility:
	extends BaseData
	enum Types { COUNT, LEVEL }
	var type: Types
	var basespeed: float
	var costs: Dictionary[Item, int]
	var count: int
	
	func _to_string() -> String:
		if type == Types.COUNT:
			return '%s, count: %d' % [key,count]
		else:
			return '%s, level: %d' % [key,count]
			
	func parse_type(type_str:String) -> Types:
		match type_str.to_lower():
			'count': return Types.COUNT
			'level': return Types.LEVEL
			_: return Types.COUNT

# 交易项类
class Trade:
	extends BaseData
	var orders: Dictionary[Item,int]
	var rewards: Dictionary[Item,int]

# 研究项类
class Research:
	extends BaseData
	var costs: Dictionary[Item,int]
	var effects: Dictionary[String,int]

# 行动项类
class Operations:
	extends BaseData
	var costs: Dictionary[Item,int]
	var effects: Dictionary[String,int]
	var cooldown: int

# 成就项类
class Achievement:
	extends BaseData
	enum Ranges { GLOBAL, LEVEL }
	var in_range: Ranges
	var targets: Dictionary[String,int]
	var effects: Dictionary[String,int]

# 预留
