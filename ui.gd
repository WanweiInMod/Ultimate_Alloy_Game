extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update_ui(resource_count: int) -> void:
	$TopPanel/InfoContainer/InfoLabel.update_text(resource_count)
	pass