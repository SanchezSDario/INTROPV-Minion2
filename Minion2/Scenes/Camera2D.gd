extends Camera2D

func _ready():
	pass

func _process(delta):
	if(get_parent().get_node("Player") != null):
		position = get_parent().get_node("Player").position
