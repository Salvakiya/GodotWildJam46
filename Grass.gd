tool
extends Node2D

var previous_position:Vector2

func choose(a:Array):
	return a[randi()%len(a)]

func _ready():
	
	$BKGrass.scale.x = 1 if choose([true,false]) else -1
	$BKGrass.scale.y = 1 if choose([true,false]) else -1
	$BKGrass.region_rect.position.x = choose([0,32,64])
	$FGGrass.region_rect.position.x = choose([0,16,32,48])
	$FGGrass.visible = choose([true,false])
	
	pass
