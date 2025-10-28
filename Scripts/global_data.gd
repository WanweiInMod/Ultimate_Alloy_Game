extends Node

# —————— 配置文件处理 ——————
var _dataLoader = preload("res://Scripts/Class/DataLoader.cs").new()

func _ready():
	var data = _dataLoader.LoadData(_dataLoader.DataTypes.Level, _dataLoader.Levels.Main)
	DataBuildUp(data)

# 数据字典
var Inventory = {}
var Facilities = {}

# —————— 全局数据构建函数 ——————
func DataBuildUp(data):
	for key in data.keys():
		var list = data[key]
		match key:
			"item":
				BuildItems(list)
			"facilities":
				BuildFacility(list)
		print("Build up ", key, " has complete")

# 物品字典构建
func BuildItems(items):
	for item in items:
		if not (typeof(item) == TYPE_DICTIONARY):
			continue
		
		var itemKey = str(item["key"])
		if itemKey == "":
			continue
		
		var newItem = {
			"Key": itemKey,
			"Name": str(item["name"]),
			"Description": str(item["description"]),
			"Sort": ItemParseSort(str(item["sort"])),
			"Amount": 0
		}
		Inventory[itemKey] = newItem

# 设施字典构建
func BuildFacility(facilities):
	for facility in facilities:
		if not (typeof(facility) == TYPE_DICTIONARY):
			return
		
		var facilityKey = str(facility["key"])
		if facilityKey == "":
			return
		
		var newFacility = {
			"Key": facilityKey,
			"Name": str(facility["name"]),
			"Description": str(facility["description"]),
			"Type": FacilityParseType(str(facility["type"])),
			"BaseSpeed": float(str(facility["speed"])) if str(facility["speed"]).is_valid_float() else 0.0
		}
		Facilities[facilityKey] = newFacility

# 物品分类解析
func ItemParseSort(sort):
	match sort.to_lower():
		"resource":
			return "Resource"
		"module":
			return "Module"
		"treasure":
			return "Treasure"
		_:
			return "Resource"

# 设施类型解析
func FacilityParseType(type):
	match type.to_lower():
		"count":
			return "Count"
		"level":
			return "Level"
		_:
			return "Count"

# —————— 游戏内资源管理函数 ——————

# 更新资源字典
func AddItem(itemKey, amount):
	if not Inventory.has("item." + itemKey):
		printerr("No such item ", itemKey, " in inventory")
		return
	
	Inventory["item." + itemKey].Amount += amount
	print(itemKey, " has", " add " if amount >= 0 else " reduce ", amount)

func GetItem(itemKey):
	if Inventory.has("item." + itemKey):
		return Inventory["item." + itemKey].Amount
	printerr("No such item ", itemKey, " in inventory")
	return 0

# 更新设施字典
func UpdFacility(key):
	pass