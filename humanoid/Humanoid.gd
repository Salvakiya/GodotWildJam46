extends KinematicBody2D


export(Array, String, FILE, "*.tscn") var components = []

export(Globals.FACE) var face_state = Globals.FACE.NORMAL
var next_face_state = Globals.FACE.NORMAL
export(Globals.LIGHT) var light_state = Globals.LIGHT.PURE

export var MOVE_SPEED = 80
var movement_input:Vector2

var controller
var is_player := false
var has_orb := false

# Called when the node enters the scene tree for the first time.
func _ready():
	change_light(light_state)
	change_expression(face_state)
	
	for cmp in components:
		var inst = load(cmp).instance()
		add_child(inst)
		inst.owner = self
		if inst.has_method("setup"):
			inst.setup(self)
	
	$Visual/BodyA.visible = !$Visual/BodyB.visible
	$Visual/BodyB.visible = !$Visual/BodyA.visible
	$Visual/Eyes.connect("animation_finished", self, "change_expression", [Globals.FACE.NORMAL])
	$Visual/Eyes.frame = rand_range(0,10)


func change_expression(to):
	if face_state == to:
		return
	face_state = to
	match to:
		Globals.FACE.HAPPY:
			$Visual/Eyes.animation = "Happy"
		Globals.FACE.SAD:
			$Visual/Eyes.animation = "Sad"
		Globals.FACE.NORMAL:
			$Visual/Eyes.animation = "Normal"
		Globals.FACE.ANGRY:
			$Visual/Eyes.animation = "Angry"
		Globals.FACE.SQUINT:
			$Visual/Eyes.animation = "Squint"

func change_light(to):
	light_state = to
	var material:ShaderMaterial = $Visual/BodyA.material
	material.set_shader_param("frame",to)
	material = $Visual/BodyB.material
	material.set_shader_param("frame",to)
	material = $Visual/Eyes.material
	material.set_shader_param("frame",to)

func _physics_process(delta):
	if is_instance_valid(controller):
		movement_input = controller.get_input()
	#if movement_input.x!=0 or movement_input.y!=0:
	

	var actual_movement = global_position
	move_and_slide(movement_input.normalized()*MOVE_SPEED)
	actual_movement = global_position.distance_to(actual_movement)
	if actual_movement>.2:
		$Visual/BodyA.animation = "Run"
		$Visual/BodyB.animation = "Run"
		if movement_input.x!=0:
			$Visual/BodyA.scale.x = sign(movement_input.x)
			$Visual/BodyB.scale.x = sign(movement_input.x)
			$Visual/Eyes.scale.x = sign(movement_input.x)
	else:
		$Visual/BodyA.animation = "Idle"
		$Visual/BodyB.animation = "Idle"


func damage():
	change_light(light_state+1)
	if light_state == 4:
		Globals.emit_signal("ev_level_loose")
		
		var p = get_parent()
		var e = load("res://humanoid/Humanoid.tscn").instance()
		e.components = ["res://humanoid/AIController.tscn"]
		e.global_position = global_position
		p.add_child(e)
		e.owner = p.owner
		queue_free()
	
