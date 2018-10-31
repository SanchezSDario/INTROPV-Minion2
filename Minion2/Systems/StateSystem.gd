extends Node

func update_state(caster):
	dead_state(caster)
	if(caster.death == false):
		if(!caster.hit):
			if(!caster.attack):
				idle_state(caster)
				jump_state(caster)
				walk_state(caster)
			else:
				attack_state(caster)
		else: caster.state_identifier = "Hit"

func idle_state(caster):
	if(InputSystem.not_walking()): caster.state_identifier = "Idle"

func jump_state(caster):
	if(InputSystem.action_pressed("ui_up")): caster.state_identifier = "Jump"

func walk_state(caster):
	if(InputSystem.action_pressed("ui_left")): 
		caster.state_identifier = "WalkLeft"
	if(InputSystem.action_pressed("ui_right")): 
		caster.state_identifier = "WalkRight"

func dead_state(caster):
	if(caster.life_points <= 0 and caster.death == false):
		caster.get_node("DeathSound").play()
		caster.death = true
		caster.emit_signal("dead")
		caster.state_identifier = "Death"
		caster.get_node("CollisionShape2D").disabled = true

func attack_state(caster):
	if(InputSystem.action_pressed("ui_attack")):
		caster.state_identifier = "Attack"