extends MeshInstance

func on_collect():
    globals.coins+=1
    print("COINS: ",globals.coins)
    pass
