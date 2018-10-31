extends KinematicBody2D

export (int) var gravity
export (int) var movement_speed
export (int) var jump_force
export (int) var JUMP_CONSTANT
export (int) var life_points
var floor_collision
var collision
var enemy_spoted
var attack_state
var attacking
var death

func _ready():
	set_meta("Type", "Enemy")
	$AnimatedSprite.frames.set_animation_speed("Idle", 12)
	$AnimatedSprite.frames.set_animation_speed("Walk", 12)
	$AnimatedSprite.frames.set_animation_speed("Attack", 12)
	$AnimatedSprite.frames.set_animation_speed("Hit", 12)
	$AnimatedSprite.frames.set_animation_speed("Death", 8)
	$AnimatedSprite.frames.set_animation_loop("Attack", false)
	$AnimatedSprite.frames.set_animation_loop("Death", false)
	$AnimatedSprite.frames.set_animation_loop("Hit", false)
	$AnimatedSprite.play("Idle")
	$LeftAttackCollision.enabled = true
	$RightAttackCollision.enabled = true

func _process(delta):
	collision()
	gravity(delta)

func gravity(delta_time):
	floor_collision = move_and_collide(Vector2(0, 20 - jump_force))
	if (jump_force > 0):
		jump_force -= (20 + jump_force)/2 * delta_time

func _on_VisibilityNotifier2D_viewport_entered(viewport):
	movement_speed = 1
	$AnimatedSprite.play("Walk")

func collision():
	if(!attack_state and !death):
		vission()
		check_attack($LeftAttackCollision)
		check_attack($RightAttackCollision)

func vission():
	if($VissionLeft.is_colliding() and $VissionLeft.get_collider().get_meta("Type") == "Player"):
		move_and_collide(Vector2(-movement_speed,0))
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Walk")
	elif($VissionRight.is_colliding() and $VissionRight.get_collider().get_meta("Type") == "Player"):
		move_and_collide(Vector2(movement_speed,0))
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Walk")
	else:
		$AnimatedSprite.play("Idle")

func check_attack(ray):
	if(ray.is_colliding() and 
	   ray.get_collider().get_meta("Type") == "Player" and
	   !attacking):
		attack_state = true
		ray.enabled = false
		do_attack(ray)

func do_attack(ray):
	$AnimatedSprite.play("Attack")
	attacking = true
	ray.enabled = true
	yield(get_tree().create_timer(0.8),"timeout")
	hitPlayer(ray)
	yield(get_tree().create_timer(0.5),"timeout")
	attack_state = false
	attacking = false

func hitPlayer(ray):
	if(ray.is_colliding() ):
		if(ray.get_collider().attack):
			$AnimatedSprite.play("Hit")
			damaged()
		else:
			ray.get_collider().hit(attack())

func damaged():
	life_points -= 1
	yield(get_tree().create_timer(0.5),"timeout")
	if(life_points == 0):
		death = true
		$VissionRight.enabled = false
		$VissionLeft.enabled = false
		$LeftAttackCollision.enabled = false
		$RightAttackCollision.enabled = false
		$AnimatedSprite.play("Death")
		yield(get_tree().create_timer(2),"timeout")
		drop_item()
		queue_free()

func drop_item():
	var chance = randi()%15+1
	if(chance <= 7 and chance >= 3): get_parent().drop_potion(position)
	if(chance <= 14 and chance >= 10): get_parent().drop_diamond(position)

func attack(): return 5