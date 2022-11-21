extends Panel

onready var this_scene = get_node(".")
onready var game_data
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
	
	var alldata = get_node("TopBar/Currency").save()
	
	var parseData = get_node("Shop").save()
	
	for key in parseData:
		alldata[key] = parseData[key]
	
	parseData = get_node("UpgradeTab").save()
	
	for key in parseData:
		alldata[key] = parseData[key]
	
	parseData = get_node("UpgradeTab/First").save()
	
	for key in parseData:
		alldata[key] = parseData[key]
	
	#parseData = get_node("UpgradeTab/Second").save()
	
	#for key in parseData:
	#	alldata[key] = parseData[key]
	
	#parseData = get_node("UpgradeTab/Third").save()
	
	#for key in parseData:
	#	alldata[key] = parseData[key]
	
	#parseData = get_node("UpgradeTab/Secret").save()
	
	#for key in parseData:
	#	alldata[key] = parseData[key]
	
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
