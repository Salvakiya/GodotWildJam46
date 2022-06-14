extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("fix_ray")
	pass # Replace with function body.

func fix_ray():
	var ray = $Godray
	remove_child(ray)
	get_parent().add_child(ray)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
