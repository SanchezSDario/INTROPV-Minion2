extends KinematicBody2D

export (int) var gravity
export (int) var jump_force
export (int) var movement_speed
var walk_state
var jump_state
var collision

func _ready():
	set_meta("type", "Player")
	pass

func _process(delta):
#	animation()
	collision = move_and_collide(Vector2(0, gravity - jump_force))
	move()
	collide()
	gravitation(delta)

func move():
	idle()
	move_right()
	move_left()
	jump()

func idle():
	if(!Input.is_action_pressed("ui_left") and 
	   !Input.is_action_pressed("ui_right") and
	   (collision != null and collision.collider.get_meta("type") == "Floor")):
		$AnimatedSprite.play("Idle")

func move_left():
	if(Input.is_action_pressed("ui_left")):
		$AnimatedSprite.flip_h = true
		collision = move_and_collide(Vector2(-movement_speed, 0))
		$AnimatedSprite.play("Walk")

func move_right():
	if(Input.is_action_pressed("ui_right")):
		$AnimatedSprite.flip_h = false
		collision = move_and_collide(Vector2(movement_speed, 0))
		$AnimatedSprite.play("Walk")

func jump():
	if(jump_force > 1): $AnimatedSprite.play("Hit")
	if(Input.is_action_just_pressed("ui_up")):
		jump_force = 28

func collide():
	if(collision != null and collision.collider.get_meta("type") == "Enemigo"):
		queue_free()
		print("Death")

func gravitation(delta_time):
	if (jump_force > 0): jump_force -= (gravity + jump_force)/2 * delta_time