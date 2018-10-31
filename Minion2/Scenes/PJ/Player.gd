extends KinematicBody2D

signal hit
signal dead
var state_identifier
export (int) var life_points
var diamonds
var jump_force
export (int) var movement_speed
export (int) var JUMP_CONSTANT
var floor_collision
var collision
var jump
var death
var attack
var view_to
var hit

func _ready():
	diamonds = 0
	view_to = true #right
	death = false
	attack = false
	jump_force = JUMP_CONSTANT
	set_meta("Type", "Player")

func _process(delta):
	StateSystem.update_state(self)
	if(!death):
		gravity(delta)
		attack()
		move()
		collide()

func move():
	if(!attack):
		jump_player()
		move_player()

func jump_player():
	if(InputSystem.action_just_pressed("ui_up") and !jump):
		jump_force = JUMP_CONSTANT
		jump = true

func move_player():
	move_left()
	move_right()

func move_right():
	if(InputSystem.action_pressed("ui_right")):
		view_to = true
		collision = move_and_collide(Vector2(movement_speed, 0))
		jump_player()

func move_left():
	if(InputSystem.action_pressed("ui_left")):
		view_to = false
		collision = move_and_collide(Vector2(-movement_speed, 0))
		jump_player()

func gravity(delta_time):
	if(!hit):
		floor_collision = move_and_collide(Vector2(0, 20 - jump_force))
		if (jump_force > 0):
			jump_force -= (20 + jump_force)/2 * delta_time

func collide():
	if(collision != null and collision.collider.get_meta("Type") == "Enemy"):
		collision.collider.hitPlayer(self)
	if(floor_collision != null): jump = false

func hit(damage):
	life_points -= damage
	hit = true
	$HitSound.play()
	emit_signal("hit")

func attack():
	attack_event()
#	Where is gonna to attack, left or right	
	if(view_to):
		turn_attack_on($AttackCollision)
		turn_attack_off($AttackCollision)
	else:
		turn_attack_on($AttackCollision2)
		turn_attack_off($AttackCollision2)

#Detects if input attack was pressed
func attack_event():
	if(InputSystem.action_just_pressed("ui_attack")): attack = true

#Activates the attack collision
func turn_attack_on(attackCollision):
	if(attack and 
	  ($AnimatedSprite.frame >= 4 and
	   $AnimatedSprite.frame < 9)): attackCollision.disabled = false

#Disable the attack collision
func turn_attack_off(attackCollision):
	if(attack and $AnimatedSprite.frame == 9):
		attackCollision.disabled = true
		attack = false

func _on_DeathTimer_timeout():
	queue_free()
	print("You died")

func _on_RecoveryTimer_timeout():
	$FloorCollision.disabled = false
	$CollisionShape2D.disabled = false
	hit = false

func revitalize(amount):
	life_points += amount
	if(life_points > 150): life_points = 150

func add_diamond():
	diamonds += 1