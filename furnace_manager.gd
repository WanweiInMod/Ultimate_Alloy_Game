extends Node


signal timer_activate


@export var furnace_buy_button: Button
@export var producing_timer: TextureProgressBar
@onready var global_storage := GlobalStorage

@export var furnace_timer_dur: float = 10
var furnace_timer: Timer
var furnace_count: int = 0	#TODO 分离至单独的功能脚本中

#TODO 将其改为使用Resource
var can_produce: Dictionary[StringName,float] = {
	"Copper" : 0 ,
	"Iron" : 0,
	"Silver" : 0,
	"Gold" : 0,
}


func _ready():

	furnace_buy_button.pressed.connect(_on_furnace_buy_button_pressed)
	furnace_buy_button.disabled = true

	global_storage.connect("StorageUpdated", storage_check)

	timer_activate.connect(_furnace_timer_activate)
	timer_activate.connect(storage_check)
	timer_activate.emit()

	furnace_timer = Timer.new()
	furnace_timer.timeout.connect(storage_check)
	furnace_timer.timeout.connect(produce_sources)
	add_child(furnace_timer)
	furnace_timer.owner = self

	producing_timer.value = 100
	producing_timer.hide()

	pass

func _process(_delta):
	_update_texture_timer()
	pass

func _on_furnace_buy_button_pressed() -> void:
	if global_storage.get_storage("Stone") >= 10:
		global_storage.add_storage("Stone",-10)
		furnace_count += 1
		timer_activate.emit()
	pass

func _furnace_timer_activate():
	if furnace_count != 0:
		furnace_timer.start(furnace_timer_dur)
		print("Furnace timer has start!")
		producing_timer.show()
		timer_activate.disconnect(_furnace_timer_activate)
	pass

func storage_check(_res_type = "", _value = null):
	var avaliable_source = global_storage.get_storage("Stone")
	furnace_buy_button.disabled = avaliable_source < 10 or furnace_count >= 10
	_update_buy_info()
	pass

#TODO 细化各个产物的产出概率
func produce_sources():
	var can_produce_resources: Dictionary[StringName, float] = can_produce.duplicate()

	for prod_i in range(furnace_count):
		var which_produce: StringName = can_produce_resources.keys()[randi_range(0,can_produce_resources.size() - 1)]
		can_produce_resources[which_produce] += 1.0
		pass

	for add_i in can_produce_resources:
		var how_much_produce := can_produce_resources[add_i]
		if how_much_produce == 0 : continue
		global_storage.add_storage(add_i, can_produce_resources[add_i])
		print("Furnace produced " + str(can_produce_resources[add_i]) +" of "+ add_i)
		pass
	
	pass

func _update_buy_info():
	furnace_buy_button.text = "Buy furnace \n count:" + str(furnace_count) + "/10 \ncost: 10 stones"
	pass

func _update_texture_timer():
	if !producing_timer.is_visible_in_tree(): return
	if furnace_timer.is_stopped(): return
	producing_timer.value = (furnace_timer.time_left/furnace_timer_dur) * producing_timer.max_value
	pass
