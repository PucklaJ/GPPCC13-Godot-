extends Spatial

export var COLLECTIABLE_TYPE = 0
export var ROTATE_SPEED = 10.0

var collectiable_mesh

func _ready():
    get_node("Coin").visible = false
    collectiable_mesh = get_child(COLLECTIABLE_TYPE)
    collectiable_mesh.visible = true
    get_node("Area").connect("body_entered",self,"on_body_entered")
    pass

func _process(delta):
    collectiable_mesh.rotate_y(ROTATE_SPEED/180*PI*delta)
    pass

func on_body_entered(body):
    if body == globals.player:
        collectiable_mesh.on_collect()
        queue_free()
    pass