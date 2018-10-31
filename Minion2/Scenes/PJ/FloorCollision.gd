extends CollisionShape2D

func _ready():
	set_meta("Type", "FloorCollision")
	print(get_meta("Type"))