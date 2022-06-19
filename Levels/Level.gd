extends Node2D

export (NodePath) var player:NodePath
onready var HUD = $HUD

var level_orb_count

func _ready():
	Globals.player = get_node(player)
	Globals.tilemap = $YSort/TileMap
	Globals.level = self
	
	level_orb_count = $YSort/Orbs.get_child_count()
	$HUD/orbcounter/total.text = str(level_orb_count)
	
	var topleft
	var botright
	for cell in $YSort/TileMap.get_used_cells():
		if not topleft: topleft = cell
		if not botright: botright = cell
		
		if $YSort/TileMap.get_cell(cell.x,cell.y+1) >=0:
			$YSort/TileMap.set_cell(cell.x,cell.y,1)
		if $YSort/TileMap.get_cell(cell.x,cell.y+1)==$YSort/TileMap.INVALID_CELL:
			$YSort/TileMap.set_cell(cell.x,cell.y,0)

func _physics_process(delta):
	if is_instance_valid(Globals.player):
		$Camera2D.global_position = Globals.player.global_position
