extends Panel

var game_data = {
	"upgrades" : [["100","0"],["5000","0"],["25000","0"],["100000","0"]],
	"clickUpgrades" : [["625","0"],["8500","0"],["50000","0"]],
}

var upgrades
var clickUpgrades
var choice
var choiceCheck = ["10e6","0"]

func save():
	if clickUpgrades:
		game_data.upgrades = upgrades
		game_data.clickUpgrades = clickUpgrades
		game_data.choice = choice
	return game_data

func loadsave(data):
	game_data = data


func _ready():
	get_tree().root.get_node("/root/MainScreen").loadall()
	choice = game_data.choice;
	for node in self.get_children():
		node.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
