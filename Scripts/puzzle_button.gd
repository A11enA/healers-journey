extends Area2D

signal pushed
signal unpushed
var bodies_on_button = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	



func _on_body_entered(body: Node2D) -> void:
	print("something is on top of me")
	#play Animation
	bodies_on_button += 1
	if body.is_in_group("pushable") or body is Player:
		if bodies_on_button == 1:
			$AnimatedSprite2D.play("pushed")
			#open a door by sending a signal
			pushed.emit()


func _on_body_exited(body: Node2D) -> void:
	print("nothing is on top of me")
	#play Animation
	bodies_on_button -= 1
	if bodies_on_button == 0:
		$AnimatedSprite2D.play("unpushed")
		#close door
		unpushed.emit()
