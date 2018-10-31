extends Node2D

signal drop_item(position)

export (int) var gravity
export (int) var movement_speed
export (int) var jump_force
export (int) var JUMP_CONSTANT
var floor_collision
var collision
var jump

func _ready():
	randomize()
	movement_speed = 0
	set_meta("Type", "Enemy")
	$AnimatedSprite.play("Idle")

func _process(delta):
	move()
	gravity(delta)

func move():
	collision = move_and_collide(Vector2(-movement_speed, 0))
	collision()

func gravity(delta_time):
	floor_collision = move_and_collide(Vector2(0, 20 - jump_force))
	if (jump_force > 0):
		jump_force -= (20 + jump_force)/2 * delta_time

func _on_VisibilityNotifier2D_viewport_entered(viewport):
	movement_speed = 1
	$AnimatedSprite.play("Walk")

func collision():
	if(collision != null and collision.collider.get_meta("Type") == "Player"):
		hitPlayer(collision.collider)
	if($LeftCast.is_colliding() and $LeftCast.get_collider().get_meta("Type")=="Floor"):
		movement_speed = -1
		$AnimatedSprite.flip_h = false
	if($RightCast.is_colliding() and $RightCast.get_collider().get_meta("Type")=="Floor"):
		movement_speed = 1
		$AnimatedSprite.flip_h = true

func hitPlayer(player):
	if(player.attack):
		drop_item()
		queue_free()
	else: player.hit(attack())

func drop_item():
	var chance = randi()%15+1
	if(chance <= 7 and chance >= 3): get_parent().drop_potion(position)
	if(chance <= 14 and chance >= 10): get_parent().drop_diamond(position)

func attack(): return 1