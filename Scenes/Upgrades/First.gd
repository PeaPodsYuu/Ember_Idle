extends Panel

var game_data = {
	"upgrades" : [["100","0"],["5000","0"],["25000","0"],["100000","0"]],
	"clickUpgrades" : [["625","0"],["8500","0"],["50000","0"]],
	"choice" : "0"
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
	get_tree().root.get_node("Screen").loadall()
	upgrades = game_data.upgrades
	clickUpgrades = game_data.clickUpgrades
	choice = game_data.choice
	for i in upgrades:
		for j in range(2):
			i[j] = get_parent().getScientificNotation(i[j])
	
	for i in clickUpgrades:
		for j in range(2):
			i[j] = get_parent().getScientificNotation(i[j])


func _on_Building1_pressed():
	if(int(upgrades[0][1]) < 5):
		get_parent().resolveUpgrade(upgrades[0],0,"First")


func _on_Building2_pressed():
	if(int(upgrades[1][1]) < 5):
		get_parent().resolveUpgrade(upgrades[1],1,"First")


func _on_Building3_pressed():
	if(int(upgrades[2][1]) < 5):
		get_parent().resolveUpgrade(upgrades[2],2,"First")


func _on_Building4_pressed():
	if(int(upgrades[3][1]) < 5):
		get_parent().resolveUpgrade(upgrades[3],3,"First")


func _on_Upgrade1_pressed():
	if(int(clickUpgrades[0][1]) == 0):
		get_parent().resolveUpgrade(clickUpgrades[0],0,"First Click")


func _on_Upgrade2_pressed():
	if(int(clickUpgrades[1][1]) == 0):
		get_parent().resolveUpgrade(clickUpgrades[1],1,"First Click")


func _on_Upgrade3_pressed():
	if(int(clickUpgrades[2][1]) == 0):
		get_parent().resolveUpgrade(clickUpgrades[2],2,"First Click")


func _on_Choice1_pressed():
	if choice == "0":
		get_parent().resolveUpgrade(choiceCheck,0,"First Choice1")
		if int(choiceCheck[1]) == 1:
			choice = "1"
			get_parent().updatePermission()


func _on_Choice2_pressed():
	if choice == "0":
		get_parent().resolveUpgrade(choiceCheck,0,"First Choice2")
		if int(choiceCheck[1]) == 1:
			choice = "2"
			get_parent().updatePermission()
