extends Camera

export var MOUSE_SENSETIVITY_X = 0.005
export var MOUSE_SENSETIVITY_Y = 0.005

var mouse_motion_x
var mouse_motion_y
var mouse_motion_processed = true

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
            mouse_motion_processed = false
            mouse_motion_x = 0
            mouse_motion_y = 0
    pass

func _process(delta):
    if !mouse_motion_processed and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        rotate(Vector3(0,1,0),-mouse_motion_x*MOUSE_SENSETIVITY_X)
        if rotation.x - mouse_motion_y*MOUSE_SENSETIVITY_Y < PI/2  and rotation.x - mouse_motion_y*MOUSE_SENSETIVITY_Y > -PI/2:
            rotate(get_right(),-mouse_motion_y*MOUSE_SENSETIVITY_Y)
        rotation.z = 0
        mouse_motion_processed = true
    pass

func get_right():
    var forward = get_global_transform().basis.z
    forward.y = 0
    forward = forward.normalized()
    return Vector3(0,1,0).cross(forward)
    pass

