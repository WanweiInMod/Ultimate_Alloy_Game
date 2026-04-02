extends Node


signal timer_check


@onready var furnace_buy_button: Button = $FurnaceBuyButton
@onready var global_storage: Node = GlobalStorage

var furnace_timer: Timer
var furnace_count: int = 0


func _ready():

	timer_check.connect(_furnace_timer_check)
	timer_check.connect(storage_check)
	timer_check.emit()

	furnace_timer = Timer.new()
	furnace_timer.timeout.connect(storage_check)
	furnace_timer.timeout.connect(produce_copper)
	add_child(furnace_timer)
	furnace_timer.owner = self

	pass

func _on_furnace_buy_button_pressed() -> void:
	#TODO: add furnace buying method
	pass

func _furnace_timer_check():
	if furnace_count != 0:
		furnace_timer.start(10.0)
		timer_check.disconnect(_furnace_timer_check)
	pass

func storage_check():
	if global_storage.Stones < 10:
		furnace_buy_button.disabled = true
	else: furnace_buy_button.disabled = false
	pass

func produce_copper():
	#TODO: add producing methods 
	pass