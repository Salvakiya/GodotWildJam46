extends Node2D

signal expression(what)
onready var target_position:Vector2 = global_position setget set_tp
onready var last_position := global_position

func setup(parent):
	parent.controller = self
	parent.change_light(4)
	parent.collision_layer = 1
	parent.collision_mask = 1
	connect("expression",parent,"change_expression")
	
	$HurtBox.connect("body_entered",self,"do_damage")
	
	parent.MOVE_SPEED-=rand_range(0,10)

func do_damage(body):
	if is_instance_valid(Globals.player) and body == Globals.player:
		Globals.player.damage()
		get_parent().global_position = Vector2(-1000,-1000)

func _ready():
	$LPTimer.connect("timeout", self, "roam")

func set_tp(value):
	target_position = (value/Vector2(16,10)).floor()*Vector2(16,10)
	target_position+= Vector2(8,5)

func get_input():
	var input
	if can_see(Globals.player):
		emit_signal("expression",Globals.FACE.ANGRY)
		self.target_position = Globals.player.global_position
	if target_position.distance_to(global_position)>4:
		input = Vector2(-1,0).rotated(global_position.angle_to_point(target_position))
		
	return input if input else Vector2.ZERO


func _physics_process(delta):
	if last_position.distance_to(global_position)>.5:
		$LPTimer.start(rand_range(1,5))
	last_position = global_position


func can_see(node):
	if is_instance_valid(node):
		var ct = Vector2(-200,0)
		ct = ct.rotated(global_position.angle_to_point(node.global_position))
		$RayCast2D.cast_to = ct
	$RayCast2D.force_raycast_update()
	var collider = $RayCast2D.get_collider()
	if not collider: return false
	if node == collider:
		return true

func roam():
	if rand_range(0,1)>.8:
		emit_signal("expression",Globals.FACE.SAD)
	else:
		emit_signal("expression",Globals.FACE.NORMAL)
	var x = int(rand_range(0,6))-3
	var y = int(rand_range(0,6))-3
	self.target_position = global_position + Vector2(x*16,y*5)
	var tm:TileMap = Globals.tilemap
	if tm.get_cellv(tm.world_to_map(target_position)) != tm.INVALID_CELL:
		
		call_deferred("roam")
