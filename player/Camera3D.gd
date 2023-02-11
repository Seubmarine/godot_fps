extends Node3D 

@onready var current_mouse_velocity := Vector2.ZERO

func _input(event : InputEvent):
	current_mouse_velocity = Vector2.ZERO
	if event is InputEventMouseMotion:
		current_mouse_velocity = event.relative
	if Input.is_action_just_pressed("capture_mouse"):
		print_debug("as clicked")
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#@onready var cam : Node3D = $"CamPos" 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var cam_rot = current_mouse_velocity
	rotate_y(-cam_rot.x * delta)
	$CamPos.rotate_x(-cam_rot.y * delta)
	$CamPos.rotation.x = clamp($CamPos.rotation.x, deg_to_rad(-80), deg_to_rad(78))
	current_mouse_velocity = Vector2.ZERO
