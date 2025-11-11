extends CharacterBody2D
class_name Player

const walk_speed: float = 100.0
const run_speed = 150.0
var move_speed: float = walk_speed


func _physics_process(delta: float) -> void:
	#shorthand movement
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_vector * move_speed
	if Input.is_action_pressed("heelies"):
		move_speed = run_speed
		$AnimatedSprite2D.speed_scale = 2
	else:
		move_speed = walk_speed
		$AnimatedSprite2D.speed_scale = 1
	
	if velocity.x > 0:
		$AnimatedSprite2D.play("walk_right")
	elif velocity.x < 0:
		$AnimatedSprite2D.play("walk_left")
	elif velocity.y > 0:
		$AnimatedSprite2D.play("walk_down")
	elif velocity.y < 0:
		$AnimatedSprite2D.play("walk_up")
	else:
		$AnimatedSprite2D.stop()
		
	move_and_slide()
