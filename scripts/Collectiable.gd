extends Spatial

export var COLLECTIABLE_TYPE = 0
export var ROTATE_SPEED = 10.0

var collectiable_mesh

func _ready():
    collectiable_mesh = get_child(COLLECTIABLE_TYPE)
    pass

func _process(delta):
    collectiable_mesh.rotate_y(ROTATE_SPEED/180*PI*delta)
    pass