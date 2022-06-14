extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for cell in get_used_cells():
		if get_cell(cell.x,cell.y+1) >=0:
			set_cell(cell.x,cell.y,1)
		if get_cell(cell.x,cell.y+1)==INVALID_CELL:
			set_cell(cell.x,cell.y,0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
