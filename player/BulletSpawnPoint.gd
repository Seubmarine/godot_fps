extends Marker3D

@onready var bullet_scene := preload("res://bullet/bullet.tscn")

func _physics_process(delta):
	if Input.is_action_just_pressed("fire_bullet"):
		var bullet_instance : RigidBody3D = bullet_scene.instantiate()
		add_child(bullet_instance)
		bullet_instance.set_as_top_level(true)
		bullet_instance.apply_central_impulse(-global_transform.basis.z.normalized() * 30)
