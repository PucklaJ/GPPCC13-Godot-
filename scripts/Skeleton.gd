extends RigidBody

export var MOVE_SPEED = 10

func _physics_process(delta):
    var forward = get_child(0).get_global_transform().basis.z.normalized()
    var y = linear_velocity.y
    linear_velocity = forward * MOVE_SPEED
    linear_velocity.y = y
    pass