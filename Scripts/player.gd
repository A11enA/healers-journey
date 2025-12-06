extends CharacterBody2D
class_name Player

const walk_speed: float = 100.0
const run_speed: float = 150.0
@export var move_speed: float = walk_speed
@export var push_strength: float = 140
@export var acceleration: float = 10

func _ready() -> void:
	updateHP()
	position = SceneManager.player_spawn_position
	
	$Staff.visible = false
	%Staff_area.monitoring = false

func _process(delta:float):
	if Input.is_action_just_pressed("interact"):
		attack()

func _physics_process(delta: float) -> void:
	#shorthand movement
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#velocity = move_vector * move_speed
	velocity = velocity.move_toward(move_vector * move_speed, acceleration)
	if Input.is_action_pressed("heelies"):
		move_speed = run_speed
		$AnimatedSprite2D.speed_scale = 1.5 
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
	
	
	
	var collision: KinematicCollision2D = get_last_slide_collision()
	
	if collision:
		#get colliding node
		var collider_node = collision.get_collider()
		if collider_node.is_in_group("pushable"):
			#get direction of the collision
			#make negative
			var collision_normal: Vector2 = collision.get_normal()
			collider_node.apply_central_force(-collision_normal * push_strength)
	move_and_slide()
func attack():
	pass #show weapon, somewhere hide weapon
	$Staff.visible = true
	#turn collision on and off
	%Staff_area.monitoring = true
	$Weapon_Timer.start()

func _on_hit_box_body_entered(body: CollisionShape2D) -> void:
	SceneManager.player_hp -= 1
	print(SceneManager.player_hp)
	updateHP()
	#die function reint scene
	if SceneManager.player_hp <= 0:
		die()
	#pushback
	var distance_to_player: Vector2
	distance_to_player = global_position - body.global_position
	var knockback_direction: Vector2 = distance_to_player.normalized()
	var knockback_strength: float = 200
	velocity += knockback_direction * knockback_strength
	
func die():
	SceneManager.player_hp = 3
	get_tree().call_deferred("reload_current_scene")


func _on_staff_area_body_entered(body: Node2D) -> void:
	body.hp -= 1
	SceneManager.player_hp += 1
	if body.hp <= 0:
		body.queue_free()

func updateHP():
	if SceneManager.player_hp >= 3:
		%HPBar.play("three")
	elif SceneManager.player_hp == 2:
		%HPBar.play("two")
	elif SceneManager.player_hp == 1:
		%HPBar.play("one")
	elif SceneManager.player_hp == 0:
		%HPBar.play("dead")


func _on_weapon_timer_timeout() -> void:
	$Staff.visible = false
	%Staff_area.monitoring = false
