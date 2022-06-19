extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ray = $Godray

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("fix_ray")
	connect("body_entered", self, "body_entered")

func fix_ray():
	var offset = ray.position
	remove_child(ray)
	get_parent().add_child(ray)
	ray.global_position = global_position+offset

func body_entered(body):
	if is_instance_valid(Globals.player) and body == Globals.player:
		if is_instance_valid(ray):
			ray.destroy()
		queue_free()
		Globals.collected_orbs+=1
		Globals.player.change_light(Globals.player.light_state-1)
