extends Node


@onready var global_storage := GlobalStorage

@export var sell_copper: Button
@export var sell_iron: Button
@export var sell_silver: Button
@export var sell_gold: Button

@onready var registered_seller: Dictionary[StringName, Button] = {
    "Copper" : sell_copper,
	"Iron" : sell_iron,
	"Silver" : sell_silver,
	"Gold" : sell_gold,
}

@onready var sell_price: Dictionary[StringName, float] = {
    "Copper" : 150,
	"Iron" : 150,
	"Silver" : 150,
	"Gold" : 150,
}

func _ready():

    button_init()

    pass

func button_init():
    for sell_type in registered_seller.keys():
        registered_seller[sell_type].pressed.connect(_on_seller_button_pressed.bind(sell_type))
        pass
    pass

func _on_seller_button_pressed(sell_type: StringName):
    var sell_count := global_storage.get_storage(sell_type)
    if sell_count <= 0:
        print(sell_type + " has sold out")
        return
    global_storage.add_storage(sell_type, -sell_count)
    var total_sell_price := (sell_count * sell_price[sell_type])
    global_storage.add_storage("Cash", total_sell_price)
    print(sell_type + " sold, gain " + str(total_sell_price) + " cash")
    pass
