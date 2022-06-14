extends Node2D

var is_dead:bool = false

func destroy():
	is_dead = true

func _process(delta):
	if is_dead:
		$Polygon2D.color.a -= delta*.1
		if $Polygon2D.color.a<0:
			queue_free()
