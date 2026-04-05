extends Node


signal timer_activate


@onready var furnace_buy_button: Button = $FurnaceBuyButton
@onready var global_storage := GlobalStorage

var furnace_timer: Timer
var furnace_count: int = 0	#TODO 分离至单独的功能脚本中


func _ready():

	global_storage.connect("StorageUpdated", storage_check)

	timer_activate.connect(_furnace_timer_activate)
	timer_activate.connect(storage_check)
	timer_activate.emit()

	furnace_timer = Timer.new()
	furnace_timer.timeout.connect(storage_check)
	furnace_timer.timeout.connect(produce_copper)
	add_child(furnace_timer)
	furnace_timer.owner = self

	furnace_buy_button.disabled = true

	pass

func _on_furnace_buy_button_pressed() -> void:
	if global_storage.get_storage("Stone") >= 10:
		global_storage.add_storage("Stone",-10)
		furnace_count += 1
		timer_activate.emit()
	pass

func _furnace_timer_activate():
	if furnace_count != 0:
		furnace_timer.start(10.0)
		print("Furnace timer has start!")
		timer_activate.disconnect(_furnace_timer_activate)
	pass

func storage_check(_res_type = "", _value = null):
	var avaliable_source = global_storage.get_storage("Stone")
	furnace_buy_button.disabled = avaliable_source < 10 or furnace_count >= 10
	_update_buy_info()
	pass

#TODO 拆分至其他脚本
func produce_copper():
	print("Time to Produce copper!")
	global_storage.add_storage("Copper",furnace_count)
	print("Current copper:" + str(global_storage.get_storage("Copper")))
	pass

func _update_buy_info():
	furnace_buy_button.text = "Buy furnace \n count:" + str(furnace_count) + "/10 \ncost: 10 stones"
	pass
