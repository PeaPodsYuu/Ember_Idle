extends Panel

var game_data = {
	"permission" : "1",
	"flint" : "0",
	"buildingA1" : "1"
}

var permission
var flint
var buildingA1

func save():
	if permission:
		game_data.permission = permission
		game_data.flint = flint
		game_data.buildingA1 = buildingA1
	return game_data

func loadsave(data):
	game_data = data

func _ready():
	get_tree().root.get_node("Screen").loadall()
	permission = game_data.permission
	flint = game_data.flint
	buildingA1 = game_data.buildingA1
	self.hide()
	get_node("First").hide()
	get_node("First/Choice").hide()
	get_node("Second").hide()
	get_node("Third").hide()
	get_node("Secret").hide()
	updatePermission()

func updatePermission():
	var ok = 1
	for i in get_node("First").upgrades:
		if int(i[1]) != 5:
			ok = 0
	for i in get_node("First").clickUpgrades:
		if int(i[1]) != 1:
			ok = 0
	if ok == 1:
		permission = "2"
	
	ok = 1
	
	if int(permission) >= 1:
		get_node("First").show()
		if int(permission) >= 2 && int(get_node("First").choice) > 0:
			get_node("First/Choice").show()
			get_node("Second").show()
			get_parent().get_node("Shop").game_data.choice = get_node("First").choice
			get_parent().get_node("Shop").permission = "2"
			get_parent().get_node("Shop").updatePermission()
			if int(get_node("First").choice) == 1:
				get_node("Second/Choice1").show()
			if int(get_node("First").choice) == 2:
				get_node("Second/Choice2").show()
			if int(permission) >= 3:
				get_node("Third").show()
				if int(permission) >= 4:
					get_node("Secret").show()
		else:
			if int(permission) >= 2:
				get_node("First/Choice").show()

func _on_Main_pressed():
	self.hide()


func getClick(amount, need):
	var node = get_parent().get_node("TopBar/Currency")
	var click = "1";
	if int(need) == 1:
		flint = amount
	if int(need) == 10:
		buildingA1 = amount
	if int(get_node("First").clickUpgrades[0][1]) == 1:
		click = node.changeMoney(click,"10","Misc")
	if int(get_node("First").clickUpgrades[1][1]) == 1:
		click = node.changeMoney(click,"100","Misc")
	if int(get_node("First").clickUpgrades[2][1]) == 1:
		click = node.changeMoney(click,flint,"Misc")
	
	if int(get_node("Second/Choice1").upgrades2[1][1]) > 0:
		click = node.changeMoney(click, get_parent().get_node("TopBar/Currency").moneyPerSec, "InverseSecond")
	if int(get_node("Second/Choice1").upgrades2[0][1]) > 0:
		for _i in range(get_node("Second/Choice1").upgrades2[0][1]):
			click = node.changeMoney(click,click,"Misc")
	
	if int(buildingA1) > 1:
		if 'e' in click:
			click = click.split('e')
			click[0] = String(float(click[0]) * amount)
			click = getScientificNotation(click[0]+'e'+click[1])
		else:
			click = getScientificNotation(float(click) * amount)
	
	node.moneyPerClick = click

func updateUI():
	for i in get_node("First").upgrades:
		for j in range(2):
			i[j] = getScientificNotation(i[j])
	
	for i in get_node("First").clickUpgrades:
		for j in range(2):
			i[j] = getScientificNotation(i[j])

func resolveUpgrade(array, index, section):
	var newVal
	var nextVal
	var currentVal = get_parent().get_node("TopBar/Currency").money
	
	
	
	if 'e' in array[0]:
		newVal = array[0].split('e')
	else:
		newVal = array[0]
	
	
	
	if 'e' in currentVal:
		nextVal = currentVal.split('e')
		if 'e' in array[0]:
			array[0] = getScientificNotation(array[0])
			if int(nextVal[1]) > int(newVal[1]) || int(nextVal[1]) == int(newVal[1])  && float(nextVal[0]) >= float(newVal[0]):
				nextVal[0] = String(float(nextVal[0]) - (float(newVal[0]) / pow(10,(int(nextVal[1]) - int(newVal[1])))))
				newVal[0] = String(float(newVal[0]) * 7.50)
				array[1] = String(int(array[1])+1)
		else:
			if int(nextVal[1]) >= 5 || float(nextVal[0]) * pow(10,int(nextVal[1])) >= float(newVal):
				nextVal[0] = String(float(nextVal[0]) - (float(newVal) / pow(10,int(nextVal[1]))))
				newVal = String(float(newVal) * 7.50)
				array[1] = String(int(array[1])+1)
		
	else:
		nextVal = currentVal
		if 'e' in array[0]:
			pass
		else:
			if float(nextVal) >= float(newVal):
				nextVal = String(float(nextVal) - float(newVal))
				newVal = String(float(newVal) * 7.50)
				array[1] = String(int(array[1])+1)
	
	if 'e' in currentVal:
		get_parent().get_node("TopBar/Currency").money = getScientificNotation(nextVal[0]+'e'+nextVal[1])
	else:
		get_parent().get_node("TopBar/Currency").money = getScientificNotation(nextVal)
	if 'e' in array[0]:
		array[0] = getScientificNotation(newVal[0]+'e'+newVal[1])
	else:
		array[0] = getScientificNotation(newVal)
	
	if "Click" in section:
		get_node("BottomBar/Info Tab").setMiscText(section,index)
		getClick(0,999)
	if "Choice" in section and !("Second" in section):
		pass
	if "First" in section and !("Click" in section) and !("Choice" in section):
		get_node("BottomBar/Info Tab").setText(section,index)
	if "Second" in section:
		get_node("BottomBar/Info Tab").setMiscText2(section,index)
	get_parent().get_node("Shop").updateValues()
	updateUI()
	updatePermission()

func getScientificNotation(n):
	n = String(n)
	if !('e' in n):
		n = float(n)
		var exponents = 0
		
		while n > 9:
			n = float(n)/10.00
			exponents+=1
		if(exponents>4):
			return String(n) + 'e' + String(exponents)
		return String(float(n) * pow(10,int(exponents)))
	else:
		var new = n.split('e')
		while(int(new[0]) > 99):
			new[0] = String(float(new[0]) / 10)
			new[1] = String(int(new[1]) + 1)
		while(int(new[0]) < 10):
			new[0] = String(float(new[0]) * 10)
			new[1] = String(int(new[1]) - 1)
		return String(new[0]) + 'e' + String(new[1])


