extends Node
class_name manager_class


@export_group("Timer Settings")
@export var timer_enable: bool = false
@export var timer_duration: float = 0
@export var timer_progress: TextureProgressBar = null

@export_group("Facility Settings")
@export var faci_name: String = ""
@export var faci_count: int = 0

@export_group("Producing Settings")
@export var storage_in: Array[storage_item]
@export var storage_out: Array[storage_item]

@export_group("","")
@export var buttons: Array[Button] = []


