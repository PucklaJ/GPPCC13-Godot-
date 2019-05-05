extends Spatial

var start_scale

func _ready():
    start_scale = scale
    get_node("AnimationPlayer").play("default")
    pass

func _process(delta):
    var to_player = globals.player.get_global_transform().origin - get_global_transform().origin
    to_player.y = 0
    to_player = to_player.normalized()

    var z_axis = to_player
    var y_axis = Vector3(0,1,0)
    var x_axis = y_axis.cross(z_axis)

    transform = Transform(x_axis,y_axis,z_axis,Vector3(0,0,0))
    scale = start_scale

    pass