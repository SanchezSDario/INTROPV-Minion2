extends AnimatedSprite

var player
var sprite_animation

func _ready():
	frames.set_animation_loop("Jump", false)
	frames.set_animation_speed("Jump", 7)
	frames.set_animation_speed("Walk", 10)
	frames.set_animation_loop("Death",false)
	frames.set_animation_speed("Death",7)
	frames.set_animation_loop("Attack",false)
	frames.set_animation_speed("Attack",15)
	frames.set_animation_loop("Hit",false)
	frames.set_animation_speed("Hit",10)
	player = get_parent()

func _process(delta):
	select_animation()
	play(sprite_animation)

func select_animation():
	match player.state_identifier:
		"WalkRight": 
			flip_h = false
			sprite_animation = "Walk"
		"WalkLeft": 
			flip_h = true
			sprite_animation = "Walk"
		"Jump": sprite_animation = "Jump"
		"Death": sprite_animation = "Death"
		"Attack": sprite_animation = "Attack"
		"Hit": sprite_animation = "Hit"
		_: sprite_animation = "Idle"