extends KinematicBody2D

export (int) var gravity
export (int) var jump_force
export (int) var movement_speed
var walk_state
var jump_state

func _ready():
	pass

func _process(delta):
	animation()
	move_and_collide(Vector2(0, gravity - jump_force))
	move()
	gravitation(delta)

func move():
	if(Input.is_action_pressed("ui_right")):
		position.x += movement_speed
		$AnimatedSprite.play("Walk")
	elif(Input.is_action_pressed("ui_left")):
		position.x -= movement_speed
		$AnimatedSprite.play("Walk")
	elif(Input.is_action_just_pressed("ui_up")):
		jump_force = 28
		$AnimatedSprite.play("Hit")
	else:
		$AnimatedSprite.play("Idle")

func gravitation(delta_time):
	if (jump_force > 0): jump_force -= (gravity + jump_force)/2 * delta_time

func animation():
	if(! walk_state): $AnimatedSprite.play()
	if(walk_state): 
		
		walk_state = false