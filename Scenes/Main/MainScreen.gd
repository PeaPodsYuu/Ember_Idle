extends Panel

onready var this_scene = get_node(".")
onready var game_data
onready var backup_data = {
		"money" : "0",
		"moneyPerClick" : "1",
		"moneyPerSec" : "0",
		"buildings" : [["0","15","1"],["0","300","3"],["0","1500","10"],["0","9500","40"],["0","50000","0"],["0","3211230","0"],["0","50000","0"],["0","3211230","0"],["0","123456789","0"],["0","99999999999","0"]],
		"realPayouts" : ["1","3","10","40"],
		"permission" : "1",
		"flint" : "0",
		"buildingA1" : "1",
		"upgrades" : [["100","0"],["5000","0"],["25000","0"],["100000","0"]],
		"clickUpgrades" : [["625","0"],["8500","0"],["50000","0"]],
		"choice" : "0",
		"upgrades2" : [["1","0"],["2","0"],["3","0"],["4","0"],["5","0"],["6","0"],["7","0"],["8","0"],["9","0"]]
	}
onready var _timer = null

func _ready():
	loadall()
	_timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(0.1)
	_timer.set_one_shot(false)
	_timer.start()

func saveall():
	var savefile = File.new()
	savefile.open("res://SaveFile.json",File.WRITE)
	
	var alldata = {}
	
	for node in get_tree().get_nodes_in_group("SaveNode"):
		var data = node.save()
		for key in data:
			alldata[key] = data[key]
	
	savefile.store_line(to_json(alldata))
	savefile.close()

func loadall():
	var savefile = File.new()
	if not savefile.file_exists("res://SaveFile.json"):
		saveall()
		return
	savefile.open("res://SaveFile.json",File.READ)
	var SaveNodes = get_tree().get_nodes_in_group("SaveNode")
	var data = parse_json(savefile.get_as_text())
	for ThisNode in SaveNodes:
		ThisNode.loadsave(data)
	savefile.close()

func fullDelete():
	get_node("TopBar/Currency").money = "0"
	get_node("TopBar/Currency").moneyPerClick = "1"
	get_node("TopBar/Currency").moneyPerSec = "0"
	get_node("Shop").buildings = [["0","15","1"],["0","300","3"],["0","1500","10"],["0","9500","40"],["0","50000","0"],["0","3211230","0"],["0","50000","0"],["0","3211230","0"],["0","123456789","0"],["0","99999999999","0"]]
	get_node("Shop").realPayouts = ["1","3","10","40"]
	get_node("Shop").permission = "1"
	get_node("UpgradeTab").permission = "1"
	get_node("UpgradeTab").flint = "0"
	get_node("UpgradeTab").buildingA1 = "1"
	get_node("UpgradeTab/First").upgrades = [["100","0"],["5000","0"],["25000","0"],["100000","0"]]
	get_node("UpgradeTab/First").clickUpgrades = [["625","0"],["8500","0"],["50000","0"]]
	get_node("UpgradeTab/First").choice = "0"
	get_node("UpgradeTab/Second/Choice1").upgrades2 = [["1","0"],["2","0"],["3","0"],["4","0"],["5","0"],["6","0"],["7","0"],["8","0"],["9","0"]]
	
	get_node("Shop").updatePermission()
	get_node("UpgradeTab").updatePermission()

func _on_Buildings_pressed():
	if get_node("Shop").is_visible():
		get_node("Shop").hide()
	else:
		get_node("UpgradeTab").hide()
		get_node("Shop").show()


func _on_Upgrades_pressed():
	if get_node("UpgradeTab").is_visible():
		get_node("UpgradeTab").hide()
	else:
		get_node("UpgradeTab").show()
		get_node("Shop").hide()

func _on_Timer_timeout():
	saveall()
	pass

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
