extends Node

signal ev_level_start
signal ev_level_loose
signal ev_level_win

enum FACE{HAPPY,SAD,NORMAL,ANGRY,SQUINT}
enum LIGHT{DEFAULT,PURE, LIGHT, GRAY, DARK}

var player = null
var tilemap:TileMap = null

func _ready():
	connect("ev_level_loose",self,"output",["YOU HAVE LOST"])
	connect("ev_level_win",self,"output",["YOU HAVE WON"])

func output(v):
	print(v)
