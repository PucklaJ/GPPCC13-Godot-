extends RigidBody

export var MOVE_SPEED = 10

var attacking = false

func _ready():
    get_node("ShootTimer").connect("timeout",self,"shoot")
    pass

func _physics_process(delta):
    if attacking:
        var forward = get_child(0).get_global_transform().basis.z.normalized()
        var y = linear_velocity.y
        linear_velocity = forward * MOVE_SPEED
        linear_velocity.y = y
    pass

func damage(amount,direction):
    queue_free()
    pass

func shoot():
    if attacking:
        var ball = globals.get_fireball()
        get_parent().add_child(ball)
        ball.translation = get_node("ShootPosition").get_global_transform().origin
        ball.set_direction()
    pass