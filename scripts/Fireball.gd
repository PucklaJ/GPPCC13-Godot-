extends Spatial

export var SPEED = 100
export var DAMAGE = 1

onready var hitbox = get_node("Mesh/Hitbox")

var direction = Vector3(0,0,0)
var shoot_pos = Vector3(0,0,0)

func _ready():
    hitbox.connect("body_entered",self,"on_body_enter")
    pass

func set_direction():
    shoot_pos = globals.player.get_node("ShootPosition").get_global_transform().origin
    direction = (shoot_pos - get_global_transform().origin).normalized()
    hitbox.set_collision_mask_bit(0,true)    
    hitbox.set_collision_mask_bit(1,false)
    pass

func _process(delta):
    hitbox.set_monitoring(true)
    hitbox.set_monitorable(true)
    translation += direction * SPEED * delta
    pass

func on_body_enter(body):
    if body == globals.player:
        globals.player.damage(DAMAGE,shoot_pos - get_global_transform().origin)
    elif body.get_collision_layer_bit(1):
        body.damage(DAMAGE,body.get_node("ShootPosition").get_global_transform().origin - get_global_transform().origin)
    if not body.get_collision_layer_bit(4):
        die()
        pass
    pass

func die():
    globals.return_fireball(self)
    pass