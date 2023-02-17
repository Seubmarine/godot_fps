extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.connect("timeout", queue_free)
	self.connect("body_shape_entered", _on_body_shape_entered)

func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int):
	if body.has_signal("bullet_damage"):
		body.emit_signal("bullet_damage", self)
		var idk : CollisionShape3D = body.shape_owner_get_owner(body.shape_find_owner(body_shape_index))
		var mesh : Shape3D = idk.shape
#		print_debug("idk: ", idk, mesh);
		
