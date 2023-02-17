
extends CharacterBody3D
@export var speed_walk : float = 5.0
@export var speed_sprint : float = 10.0

@export var jump_force : float = 20.0
@export_range(0.01, 1) var mouse_sentitivity_y : float = 0.006
@export_range(0.01, 1) var mouse_sentitivity_x : float = 0.006

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var cam : Camera3D = $Camera3D
func _input(event):
	if event is InputEventMouseMotion:
		event as InputEventMouseMotion
		rotation_degrees.y += -event.relative.x * mouse_sentitivity_x
		cam.rotation_degrees.x = clampf(cam.rotation_degrees.x + -event.relative.y * mouse_sentitivity_y, -89, 89)
	if Input.is_action_just_pressed("capture_mouse"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta : float):
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_force
	velocity.y += -gravity * delta * 7
	var speed = speed_walk
	if Input.is_action_pressed("sprint"):
		speed = speed_sprint

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	var new_vel : Vector3 = ((input_dir.y * transform.basis.z) + (input_dir.x * transform.basis.x)).normalized()
	velocity.x = new_vel.x * speed
	velocity.z = new_vel.z * speed
	move_and_slide()
