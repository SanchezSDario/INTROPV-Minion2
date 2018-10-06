extends Node

func execute(caster):
	match caster.get_meta("Type"):
		"Player": 
			jump_player(caster)
			move_player(caster)
		"Enemy": 
			move_enemy(caster)

func move_enemy(caster):
	caster.collision = caster.move_and_collide(Vector2(-caster.movement_speed, 0))

func jump_player(caster):
	if(InputSystem.action_just_pressed("ui_up") and !caster.jump):
		caster.jump_force = caster.JUMP_CONSTANT
		caster.jump = true

func move_player(caster):
	move_left(caster)
	move_right(caster)

func move_right(caster):
	if(InputSystem.action_pressed("ui_right")):
		caster.collision = caster.move_and_collide(Vector2(caster.movement_speed, 0))
		jump_player(caster)

func move_left(caster):
	if(InputSystem.action_pressed("ui_left")):
		caster.collision = caster.move_and_collide(Vector2(-caster.movement_speed, 0))
		jump_player(caster)