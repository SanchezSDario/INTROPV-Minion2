extends Node2D

export (int) var gravity
export (int) var movement_speed
var collision

func _ready():
	movement_speed = 0
	set_meta("type", "Enemigo")
	$AnimatedSprite.play("Idle")
	pass

func _process(delta):
	position.x -= movement_speed
	collision = move_and_collide(Vector2(0, gravity))
	collide()
#	gravitation(delta)

func _on_VisibilityNotifier2D_viewport_entered(viewport):
	movement_speed = 2
	$AnimatedSprite.play("Walk")

func collide():
	if(collision != null and collision.collider.get_meta("type") == "Enemigo"):
		collision.collider.queue_free()
		print("Death")

#func gravitation(delta_time):
#	if (jump_force > 0): jump_force -= (gravity + jump_force)/2 * delta_time