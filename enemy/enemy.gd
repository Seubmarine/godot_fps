extends CharacterBody3D

func _ready():
	connect("bullet_damage", _on_bullet_damage)
	print_debug(player.global_position)
	$NavigationAgent3D.target_position = player.global_position

signal bullet_damage

func _on_bullet_damage(bullet : Node3D):
	var previous_value : bool = $MeshInstance3D.get_instance_shader_parameter("hit")
	$MeshInstance3D.set_instance_shader_parameter("hit", !previous_value)

@export var player : Node3D

func _physics_process(_delta):
	# Query the `NavigationAgent` to know the next free to reach location.
	$NavigationAgent3D.target_position = player.global_position
	var target = $NavigationAgent3D.get_next_path_position()
	
	var player_pos = (target * Vector3(1, 0, 1) - global_position * Vector3(1, 0, 1)).normalized()
	var enemy_forward = (-transform.basis.z).normalized()
	var angle_to = enemy_forward.signed_angle_to(player_pos, Vector3.UP)
	
	var lang = lerp(rotation.y, rotation.y + angle_to, _delta * 10)
	print("lerp: ", lang)
	rotation.y = lang
#	var prout : Vector3 = lerp(-transform.basis.z, target, 0.4).dot()
	velocity = (-transform.basis.z).normalized() * 40
	if !is_on_floor():
		velocity.y = -9.8
	move_and_slide()
