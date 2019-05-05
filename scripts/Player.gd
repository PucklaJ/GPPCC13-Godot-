extends RigidBody

export var SPEED = 10
export var JUMP_POWER = 10
export var ACCELARATION = 100
export var MOUSE_SENSETIVITY_X = 0.005
export var MOUSE_SENSETIVITY_Y = 0.005
export var DAMPING = 1.1

var camera
var is_grounded

var mouse_motion_x
var mouse_motion_y
var mouse_motion_processed

func _ready():
    camera = get_node("Camera")
    mouse_motion_processed = true
    contact_monitor = true
    contacts_reported = 2
    connect("body_shape_entered",self,"_body_shape_entered")
    pass

func _physics_process(delta):
    process_mouse()
    process_buttons(delta)
    pass

func _input(event):
    if event is InputEventMouseMotion:
        mouse_motion_x = event.relative.x
        mouse_motion_y = event.relative.y
        mouse_motion_processed = false
    elif Input.is_action_just_pressed("toggle_mouse_lock"):
        if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
            Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
        else:
            Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
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

    pass

func process_mouse():
    if !mouse_motion_processed and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        camera.rotate(get_up(),-mouse_motion_x*MOUSE_SENSETIVITY_X)
        if camera.rotation.x - mouse_motion_y*MOUSE_SENSETIVITY_Y < PI/2  and camera.rotation.x - mouse_motion_y*MOUSE_SENSETIVITY_Y > -PI/2:
            camera.rotate(get_right(),-mouse_motion_y*MOUSE_SENSETIVITY_Y)
        camera.rotation.z = 0
        mouse_motion_processed = true
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


func _body_shape_entered(body_id,body,body_shape,local_shape):
    print(local_shape)
    pass