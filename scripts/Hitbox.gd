extends Area

onready var weapon = get_parent()
onready var collision_shape = get_child(0)

func _ready():
    connect("body_entered",self,"on_hitbox_enter")
    set_hitbox_shape()
    pass

func on_hitbox_enter(body):
    if globals.player.is_main_attacking and body.has_method("damage"):
        body.damage(weapon.DAMAGE)
    pass

func set_hitbox_shape():
    var aabb = weapon.get_aabb()

    collision_shape.shape.extents = aabb.size*weapon.scale
    collision_shape.translation.y = aabb.size.y/2*weapon.scale.y
    pass