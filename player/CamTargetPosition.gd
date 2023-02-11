extends Node3D
#
#
## Called when the node enters the scene tree for the first time.
func _ready():
	$Camera3D.set_as_top_level(true)

func lerp_angle_vector3(from : Vector3, to : Vector3, weight : float) -> Vector3:
	var new := Vector3()
	new.x = lerp_angle(from.x, to.x, weight)
	new.y = lerp_angle(from.y, to.y, weight)
	new.z = lerp_angle(from.z, to.z, weight)
	return (new)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_rotation : Vector3 = global_rotation
	$Camera3D.global_rotation = lerp_angle_vector3($Camera3D.global_rotation, target_rotation, min(1.0, delta * 20));
	var target_origin : Vector3 = global_transform.origin
	$Camera3D.global_transform.origin = global_transform.origin
#	print($Camera3D.global_transform.origin)
