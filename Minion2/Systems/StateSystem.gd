extends Node

func update_state(caster):
	dead_state(caster)
	if(caster.death == false):
		idle_state(caster)
		walk_state(caster)

func idle_state(caster):
	if(InputSystem.not_walking()): caster.state_identifier = "Idle"

func walk_state(caster):
	if(InputSystem.action_pressed("ui_up")):
		caster.state_identifier = "Jump"
	if(InputSystem.action_pressed("ui_left")): 
		caster.state_identifier = "WalkLeft"
	if(InputSystem.action_pressed("ui_right")): 
		caster.state_identifier = "WalkRight"

func dead_state(caster):
	if(caster.life_points <= 0 and caster.death == false):
		caster.death = true
		caster.emit_signal("dead")
		caster.state_identifier = "Death"