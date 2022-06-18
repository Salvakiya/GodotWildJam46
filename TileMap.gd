extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	var topleft
	var botright
	for cell in get_used_cells():
		if not topleft: topleft = cell
		if not botright: botright = cell
		
		if get_cell(cell.x,cell.y+1) >=0:
			set_cell(cell.x,cell.y,1)
		if get_cell(cell.x,cell.y+1)==INVALID_CELL:
			set_cell(cell.x,cell.y,0)



