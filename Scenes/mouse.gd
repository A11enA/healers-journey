extends CharacterBody2D


@export var speed = 30
@export var hp:int = 3

var target: Node2D

func _physics_process(delta: float) -> void:
	if target:
		chasing()
	else:
		#random or patrol
		speed = 50
	animate_enemy()
	
	move_and_slide()

func chasing():
	var distance_to_player: Vector2
	distance_to_player = target.global_position - $CollisionPolygon2D.global_position
	var direction_normal: Vector2 = distance_to_player.normalized()
	if speed > 0.0:
		speed -=0.01
	velocity += direction_normal * speed
	
func animate_enemy():
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

func _on_chasing_radius_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body
		speed = 30
