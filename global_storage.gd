extends Node

signal StorageUpdated(item_type: StringName, value: float)


var storage: Dictionary[StringName, float] = {
    "Stone": 0,
    "Copper": 0,
}

var facility: Dictionary[StringName, float] = {
    "Furnace": 0,
}


func set_storage(item_type: StringName, value: float):
    if storage.set(item_type, value):
        StorageUpdated.emit(item_type, value)
        return
    printerr("Resource type '" + item_type + "' does not exist.")

func get_storage(item_type: StringName) -> float :
    if storage.has(item_type):
        return storage.get(item_type)
    printerr("Resource type '" + item_type + "' does not exist.")
    return 0

func add_storage(item_type: StringName, value: float):
    if storage.has(item_type):
        storage[item_type] += value
        StorageUpdated.emit(item_type, value)
        return
    printerr("Resource type '" + item_type + "' does not exist.")
    pass

func new_storage(item_type: StringName, value: float):
    if storage.has(item_type):
        printerr("Resource type '" + item_type + "' already exist.")
        return
    storage[item_type] = value
    StorageUpdated.emit(item_type, value)
    pass

