extends Panel

var game_data = {
	"upgrades2" : [["1","0"],["2","0"],["3","0"],["4","0"],["5","0"],["6","0"],["7","0"],["8","0"],["9","0"]],
}

var upgrades2
var choiceCheck = ["10e6","0"]

func save():
	if upgrades2:
		game_data.upgrades2 = upgrades2
	return game_data

func loadsave(data):
	game_data = data


func _ready():
	get_tree().root.get_node("/root/MainScreen").loadall()
	upgrades2 = game_data.upgrades2
	pass


func _on_Button_pressed():
	if(int(upgrades2[0][1]) < 5):
		get_parent().get_parent().resolveUpgrade(upgrades2[0],0,"Second/Choice1")


func _on_Button2_pressed():
	if(int(upgrades2[1][1]) < 5):
		get_parent().get_parent().resolveUpgrade(upgrades2[1],1,"Second/Choice1")


func _on_Button3_pressed():
	if(int(upgrades2[2][1]) < 5):
		get_parent().get_parent().resolveUpgrade(upgrades2[2],2,"Second/Choice1")


func _on_Button4_pressed():
	if(int(upgrades2[3][1]) < 5):
		get_parent().get_parent().resolveUpgrade(upgrades2[3],3,"Second/Choice1")


func _on_Button5_pressed():
	if(int(upgrades2[4][1]) < 5):
		get_parent().get_parent().resolveUpgrade(upgrades2[4],4,"Second/Choice1")


func _on_Button6_pressed():
	if(int(upgrades2[5][1]) < 5):
		get_parent().get_parent().resolveUpgrade(upgrades2[5],5,"Second/Choice1")


func _on_Button7_pressed():
	if(int(upgrades2[6][1]) < 5):
		get_parent().get_parent().resolveUpgrade(upgrades2[6],6,"Second/Choice1")


func _on_Button8_pressed():
	if(int(upgrades2[7][1]) < 5):
		get_parent().get_parent().resolveUpgrade(upgrades2[7],7,"Second/Choice1")


func _on_Button9_pressed():
	if(int(upgrades2[8][1]) < 5):
		get_parent().get_parent().resolveUpgrade(upgrades2[8],8,"Second/Choice1")
