extends Panel

var game_data = {
	"buildings" : [["0","15","1"],["0","300","3"],["0","1500","10"],["0","9500","40"],["0","50000","0"],["0","3211230","0"],["0","50000","0"],["0","3211230","0"],["0","123456789","0"],["0","99999999999","0"]],
	"realPayouts" : ["1","3","10","40"],
	"permission" : "1"
}

var buildings
var realPayouts
var permission

func save():
	if permission:
		game_data.buildings = buildings
		game_data.realPayouts = realPayouts
		game_data.permission = permission
	return game_data

func loadsave(data):
	game_data = data

func updatePermission():
	for child in self.get_children():
		if "Building" in child.name || "Ascension" in child.name:
			child.hide()
	if int(permission) > 0:
		get_node("Building1").show()
		get_node("Building2").show()
		get_node("Building3").show()
		get_node("Building4").show()
		if int(permission) > 1:
			if int(game_data.choice) == 1:
				get_node("Building5A").show()
				get_node("Building6A").show()
			if int(game_data.choice) == 2:
				get_node("Building5B").show()
				get_node("Building6B").show()
			if int(permission) > 2:
				get_node("Building7").show()
				get_node("Building8").show()

func _ready():
	get_tree().root.get_node("Screen").loadall()
	buildings = game_data.buildings
	realPayouts = game_data.realPayouts
	permission = game_data.permission
	for i in range(8):
		for j in range(3):
			buildings[i][j] = getScientificNotation(buildings[i][j])
	updatePermission()
	updateUI()
	get_node(".").hide()


func updateUI():
		
	var i = 0
	for child in self.get_children():
		if "Building" in child.name:
			var name = child.get_node("Price").get_text().split("\n")
			if !('e' in buildings[i][1]):
				child.get_node("Price").text = name[0] + "\n" + "%.2f" % float(buildings[i][1])
			else:
				var mymoney = buildings[i][1].split('e')
				child.get_node("Price").text = name[0] + "\n" + "%.2f" % float(mymoney[0]) + 'e' + mymoney[1]
			i+=1


func _on_Main_pressed():
	get_node(".").hide()
	pass

func computePS():
	var profit = "0"
	for i in range(4):
		if int(buildings[i][2]) != 0:
			for _j in range(int(buildings[i][0])):
				profit = get_parent().get_node("TopBar/Currency").changeMoney(profit,realPayouts[i],"Building")
		if i == 0:
			get_parent().get_node("UpgradeTab").getClick(profit,1)
		get_parent().get_node("TopBar/Currency").moneyPerSec = profit

func choice1Buildings():
	var adder = float(1.00)
	if int(game_data.choice) == 1:
		for _i in range(buildings[4][0]):
			adder *= 1.03
	print(adder)
	get_parent().get_node("UpgradeTab").getClick(adder, 10)

func resolveAcquisition(array):
	var newVal
	var nextVal
	var currentVal = get_parent().get_node("TopBar/Currency").money
	
	
	
	if 'e' in array[1]:
		newVal = array[1].split('e')
	else:
		newVal = array[1]
	
	
	
	if 'e' in currentVal:
		nextVal = currentVal.split('e')
		if 'e' in array[1]:
			if int(nextVal[1]) > int(newVal[1]) || int(nextVal[1]) == int(newVal[1])  && float(nextVal[0]) >= float(newVal[0]):
				nextVal[0] = String(float(nextVal[0]) - (float(newVal[0]) / pow(10,(int(nextVal[1]) - int(newVal[1])))))
				newVal[0] = String(float(newVal[0]) * 1.21)
				array[0] = String(int(array[0])+1)
		else:
			if int(nextVal[1]) >= 5 || float(nextVal[0]) * pow(10,int(nextVal[1])) >= float(newVal):
				nextVal[0] = String(float(nextVal[0]) - (float(newVal) / pow(10,int(nextVal[1]))))
				newVal = String(float(newVal) * 1.21)
				array[0] = String(int(array[0])+1)
		
	else:
		nextVal = currentVal
		if 'e' in array[1]:
			pass
		else:
			if float(nextVal) >= float(newVal):
				nextVal = String(float(nextVal) - float(newVal))
				newVal = String(float(newVal) * 1.21)
				array[0] = String(int(array[0])+1)
	
	
	if 'e' in currentVal:
		get_parent().get_node("TopBar/Currency").money = getScientificNotation(nextVal[0]+'e'+nextVal[1])
	else:
		get_parent().get_node("TopBar/Currency").money = getScientificNotation(nextVal)
	if 'e' in array[1]:
		array[1] = getScientificNotation(newVal[0]+'e'+newVal[1])
	else:
		array[1] = getScientificNotation(newVal)

	computePS()
	updateUI()

func updateValues():
	for i in range(4):
		realPayouts[i] = buildings[i][2]
		for _j in range(get_parent().get_node("UpgradeTab/First").upgrades[i][1]):
			realPayouts[i] = get_parent().get_node("TopBar/Currency").changeMoney(realPayouts[i],realPayouts[i],"Upgrade")
	computePS()
	updateUI()


func _on_Button1_pressed():
	resolveAcquisition(buildings[0])

func _on_Button2_pressed():
	resolveAcquisition(buildings[1])

func _on_Button3_pressed():
	resolveAcquisition(buildings[2])

func _on_Button4_pressed():
	resolveAcquisition(buildings[3])

func _on_Button5A_pressed():
	resolveAcquisition(buildings[4])
	choice1Buildings()

func _on_Button7_pressed():
	resolveAcquisition(buildings[6])

func _on_Button8_pressed():
	resolveAcquisition(buildings[7])

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

