extends Control


@onready var global_storage := GlobalStorage
@onready var storage := GlobalStorage.storage
@export var label_container: Container


func _ready():
	#TODO 完善标签的自动生成
	var labels := label_container.get_children()
	var storage_keys: Array[StringName]= storage.keys()
	for item_i in range( 0 , label_container.get_child_count() ):
		var label := labels[item_i]
		if item_i != 0 :
			label.hide()
			pass
		label.storage_item = storage_keys[item_i]
		print(storage_keys[item_i])
		pass
	pass

