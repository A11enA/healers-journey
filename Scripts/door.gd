extends StaticBody2D

@export var button_presses_needed: int = 1
#keep track of how many buttons are pressed
var buttons_pressed: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_puzzle_button_pushed() -> void:
	buttons_pressed += 1
	if buttons_pressed == button_presses_needed:
		$AnimatedSprite2D.animation = "open"
		$CollisionShape2D.set_deferred("disabled", true)
		$move.play()


func _on_puzzle_button_unpushed() -> void:
	if buttons_pressed != button_presses_needed:
		$AnimatedSprite2D.animation = "closed"
		$CollisionShape2D.set_deferred("disabled", false)
		$move.play()
