extends Node

func execute(caster):
	if(caster.collision != null):
		match caster.collision.collider.get_meta("Type"):
			"Floor": caster.jump = false
			"Enemy":
				caster.life_points -= caster.collision.collider.attack()
				caster.emit_signal("hit")
			"Player":
				caster.collision.collider.life_points -= caster.attack()
				caster.collision.collider.emit_signal("hit")