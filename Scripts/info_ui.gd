extends Control



func _on_update_info(count:int) -> void:
	print('Info has updated.')
	$InfoCount.text = str(count)
	return
