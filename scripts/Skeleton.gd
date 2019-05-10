extends RigidBody

export var MOVE_SPEED = 10
export var FIRE_RATE = 1.0

func _ready():
    get_node("ShootTimer").connect("timeout",self,"shoot")
    pass

func _physics_process(delta):
    var forward = get_child(0).get_global_transform().basis.z.normalized()
    var y = linear_velocity.y
    linear_velocity = forward * MOVE_SPEED
    linear_velocity.y = y
    pass

func damage(amount):
    queue_free()
    pass

func shoot():
    var ball = globals.get_fireball()
    get_parent().add_child(ball)
    ball.translation = get_node("ShootPosition").get_global_transform().origin
    ball.set_direction()
    pass