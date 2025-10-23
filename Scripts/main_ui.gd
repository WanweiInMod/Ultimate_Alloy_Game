extends CanvasLayer

signal update_info(count:int)

@onready var global_data: Node = get_node("/root/GlobalData")

const MAX_INFO_LABEL_COUNT : int = 6
var info_label_list : Array[InfoUi]
var info_item_textures : Array[Texture2D] 

func _ready() -> void:
	
	return


func _update_info() -> void:
	
	print("Label Updating")
	var info_test: int = global_data.GetItem('stone')  
	update_info.emit(info_test)
	
	return 
