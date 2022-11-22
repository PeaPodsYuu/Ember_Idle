extends Panel


func _ready():
	get_tree().root.get_node("/root/MainScreen").loadall()
	for node in self.get_children():
		node.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
