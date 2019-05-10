extends RigidBody

export var SPEED = 10
export var JUMP_POWER = 10
export var ACCELARATION = 100
export var DAMPING = 1.1
export var MAX_HEALTH = 5.0

var camera
var is_grounded
var is_main_attacking
var health

func _ready():
    globals.player = self

    camera = get_node("Camera")
    health = MAX_HEALTH
    is_main_attacking = false
    pass

func _physics_process(delta):
    process_buttons(delta)
    pass

func process_buttons(delta):
    var vel = Vector3(0,0,0)
    if Input.is_action_pressed("move_forward"):
        vel += Vector3(0,0,-1)
    if Input.is_action_pressed("move_backward"):
        vel += Vector3(0,0,1)
    if Input.is_action_pressed("move_left"):
        vel += Vector3(-1,0,0)
    if Input.is_action_pressed("move_right"):
        vel += Vector3(1,0,0)

    if vel.length_squared() != 0: # Any Button is pressed
        vel = vel.normalized() * ACCELARATION
        vel = vel.x*get_right()+vel.z*get_forward()
        add_force(vel.normalized()*ACCELARATION,Vector3(0,0,0))
    else: # No button is pressed
        vel.x = linear_velocity.x # Slow Down
        vel.z = linear_velocity.z
        var length = vel.length() / DAMPING
        vel = vel.normalized()*length
        linear_velocity.x = vel.x
        linear_velocity.z = vel.z

    vel.x = linear_velocity.x
    vel.z = linear_velocity.z

    if vel.length_squared() > SPEED*SPEED: # max velocity
        vel = vel.normalized()*SPEED
        linear_velocity.x = vel.x
        linear_velocity.z = vel.z


    if is_grounded && Input.is_action_just_pressed("jump"):
        apply_central_impulse(Vector3(0,JUMP_POWER,0))
    
    if !is_main_attacking and Input.is_action_just_pressed("main_attack"):
        is_main_attacking = true

    pass

func damage(amount,direction):
    health -= amount
    if health <= 0.0:
        die()
    pass

func remove_all_children(parent):
    for c in parent.get_children():
        remove_all_children(c)
        parent.remove_child(c)
    pass

func die():
    globals.reset()
    pass

func get_forward():
    var cam_forward = camera.get_global_transform().basis.z
    return Vector3(cam_forward.x,0,cam_forward.z).normalized()
    pass

func get_right():
    return get_up().cross(get_forward())
    pass

func get_up():
    return Vector3(0,1,0)
    pass