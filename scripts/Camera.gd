extends Camera

export var MOUSE_SENSETIVITY_X = 0.005
export var MOUSE_SENSETIVITY_Y = 0.005
export var AXIS_SENSITIVITY_X = 100.0
export var AXIS_SENSITIVITY_Y = 100.0
export var AXIS_DEADZONE = 0.1

onready var joy_axis_curve = load("res://misc/JoyAxisSensitivityCurve.tres")

const JOY_AXIS_VERTICAL = JOY_AXIS_3
const JOY_AXIS_HORIZONTAL = JOY_AXIS_2
const JOY_DEVICE = 0

var mouse_motion_x = 0
var mouse_motion_y = 0
var mouse_motion_processed = true

func _input(event):
    if event is InputEventMouseMotion:
        if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
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
    if mouse_motion_processed:
        read_axis_values()

    if !mouse_motion_processed:
        process_mouse_motion()
    pass

func read_axis_values():
    if not Input.get_connected_joypads().has(0):
        return
    var axis_value_y = Input.get_joy_axis(JOY_DEVICE,JOY_AXIS_VERTICAL)
    var axis_value_x = Input.get_joy_axis(JOY_DEVICE,JOY_AXIS_HORIZONTAL)
    if abs(axis_value_x) > AXIS_DEADZONE:
        var strength = joy_axis_curve.interpolate(abs(axis_value_x))
        mouse_motion_x = sign(axis_value_x) * strength * AXIS_SENSITIVITY_X
        mouse_motion_processed = false
    if abs(axis_value_y) > AXIS_DEADZONE:
        var strength = joy_axis_curve.interpolate(abs(axis_value_y))
        mouse_motion_y = sign(axis_value_y) * strength * AXIS_SENSITIVITY_Y
        mouse_motion_processed = false
    pass

func process_mouse_motion():
    print(rotation.x)
    rotate(Vector3(0,1,0),-mouse_motion_x*MOUSE_SENSETIVITY_X)
    if rotation.x - mouse_motion_y*MOUSE_SENSETIVITY_Y < PI/2  and rotation.x - mouse_motion_y*MOUSE_SENSETIVITY_Y > -PI/2:
        rotate(get_right(),-mouse_motion_y*MOUSE_SENSETIVITY_Y)
    rotation.z = 0
    mouse_motion_x = 0
    mouse_motion_y = 0
    mouse_motion_processed = true
    pass



func get_right():
    var forward = get_global_transform().basis.z
    forward.y = 0
    forward = forward.normalized()
    return Vector3(0,1,0).cross(forward)
    pass

