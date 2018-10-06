extends Camera2D

var shake_amount = 3.0

func _process(delta):
	if(get_parent().has_node("Player")):
		position = get_parent().get_node("Player").position

func _on_Player_hit():
	 set_offset(Vector2( \
        rand_range(-1.0, 1.0) * shake_amount, \
        rand_range(-1.0, 1.0) * shake_amount \
    ))
