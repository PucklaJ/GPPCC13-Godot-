extends Spatial

func _process(delta):
    for c in get_children():
        if c.is_colliding():
            get_parent().is_grounded = true
            return
    
    get_parent().is_grounded = false
    pass