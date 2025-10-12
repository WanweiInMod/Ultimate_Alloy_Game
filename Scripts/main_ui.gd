extends CanvasLayer

signal update_info(count:int)

var info_label: 	Control
var global_data: 	Node

func _ready() -> void:
	
	global_data = get_node("/root/GlobalData")
	info_label = $PanelTop/InfoContainer/SampleInfo
	
	return


func _update_info() -> void:
	
	var info_test: int = global_data.GetItem('stone')  
	update_info.emit(info_test)
	
	return 
