extends Node

signal ev_level_start
signal ev_level_loose
signal ev_level_win

enum FACE{HAPPY,SAD,NORMAL,ANGRY,SQUINT}
enum LIGHT{DEFAULT,PURE, LIGHT, GRAY, DARK}

var player = null
var tilemap:TileMap = null
var level = null

var collected_orbs = 0 setget set_orb

func _ready():
	connect("ev_level_loose",self,"loose_game")
	connect("ev_level_win",self,"win_game")

func set_orb(value):
	collected_orbs = value
	level.get_node("HUD/orbcounter/count").text = str(collected_orbs)
	


func _physics_process(delta):
	if level.level_orb_count <= collected_orbs:
		emit_signal("ev_level_win")

func win_game():
	get_tree().root.get_node("Level/HUD/win_message").visible = true
	get_tree().paused = true
	

func loose_game():
	get_tree().root.get_node("Level/HUD/loose_message").visible = true
