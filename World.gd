extends Node2D


onready var navigation_target = $YSort/Humanoid
onready var tilemap = $YSort/TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.player = $YSort/Humanoid
	Globals.tilemap = $YSort/TileMap
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_instance_valid(Globals.player):
		$Camera2D.global_position = Globals.player.global_position
