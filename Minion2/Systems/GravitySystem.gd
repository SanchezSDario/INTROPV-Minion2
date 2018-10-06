extends Node


func apply(caster, delta_time):
	caster.collision = caster.move_and_collide(Vector2(0, 20 - caster.jump_force))
	if (caster.jump_force > 0):
		caster.jump_force -= (20 + caster.jump_force)/2 * delta_time