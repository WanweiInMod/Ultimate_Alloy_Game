extends Node


signal timer_activate


@onready var furnace_buy_button: Button = $FurnaceBuyButton
@onready var global_storage: Node = GlobalStorage

var furnace_timer: Timer
var furnace_count: int = 0


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
	if global_storage.GetStorage("Stone") >= 10:
		global_storage.AddStorage("Stone",-10)
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
	var avaliable_source = global_storage.GetStorage("Stone")
	furnace_buy_button.disabled = avaliable_source < 10 or furnace_count >= 10
	_update_buy_info()
	pass

func produce_copper():
	print("Time to Produce 1 copper!")
	#TODO: add producing methods 
	pass

func _update_buy_info():
	furnace_buy_button.text = "Click to buy \n Furnace \n count:" + str(furnace_count) + "/10 \ncost: 10 stones"
	pass
