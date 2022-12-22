extends Label
class_name Currency

var game_data = {
	"money" : "0",
	"moneyPerClick" : "1",
	"moneyPerSec" : "0"
}
var money
var moneyPerClick
var moneyPerSec
var _timer = null
var _longTimer = null

func save():
	if money:
		game_data.money = money
		game_data.moneyPerClick = moneyPerClick
		game_data.moneyPerSec = moneyPerSec
	return game_data

func loadsave(data):
	game_data = data

func _ready():
	get_tree().root.get_node("/root/MainScreen").loadall()
	money = game_data.money
	moneyPerClick = game_data.moneyPerClick
	moneyPerSec = game_data.moneyPerSec

	
	_timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(0.1)
	_timer.set_one_shot(false)
	_timer.start()
	
	_longTimer = Timer.new()
	add_child(_longTimer)
	_longTimer.connect("timeout", self, "_on_LongTimer_timeout")
	_longTimer.set_wait_time(1)
	_longTimer.set_one_shot(false)
	_longTimer.start()

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


func changeMoney(target,n,type):
	var currentmoney
	var currentvalue
	var currentexponent
	var add
	var addvalue
	var addexponent
	if 'e' in target:
		currentmoney = target.split('e')
		currentvalue = float(currentmoney[0])
		currentexponent = int(currentmoney[1])
	else:
		currentvalue = float(target)
		currentexponent = 0
	
	if 'e' in String(n):
		add = n.split('e')
		addvalue = float(add[0])
		addexponent = int(add[1])
	else:
		addvalue = float(n)
		addexponent = 0
	
	if type == "Second":
		if addexponent > 1:
			addexponent -= 1
		else:
			addvalue = float(addvalue) / 10.00
	if type == "InverseSecond":
		if addexponent > 1:
			addexponent += 2
		else:
			addvalue = float(addvalue) * 100.00
	if type == "Multiply" && float(n) > 1:
		currentvalue = float(currentvalue) * float(n)
	
	if currentexponent > addexponent:
		currentvalue += addvalue / pow(10, (currentexponent-addexponent))
	if currentexponent < addexponent && addexponent >=3:
		currentvalue = 10
		currentexponent = addexponent
	if currentexponent < addexponent && addexponent < 3:
		currentvalue = 10
		currentexponent = 3
	if currentexponent == addexponent:
		currentvalue += addvalue
	
	
	if currentexponent >= 3:
		target = getScientificNotation(String(currentvalue)+'e'+String(currentexponent))
	else:
		if currentvalue < 10000:
			target = getScientificNotation(String(currentvalue*pow(10,currentexponent)))
		else:
			currentexponent = 4
			currentvalue /= 10000
			target = getScientificNotation(String(currentvalue)+'e'+String(currentexponent))
			
	return target


func updateUI():
	if !('e' in money):
		text = "%.2f" % float(money) + " Flame"
	else:
		var mymoney = money.split('e')
		text = "%.2f" % float(mymoney[0]) + 'e' + mymoney[1] + " Flame"
	
	get_parent().get_node("Currency2").text = getScientificNotation(moneyPerSec) + " Flame / s"
	var temp = changeMoney(moneyPerClick,(1+float(get_parent().get_parent().get_node("Shop").buildings[4][0])/10),"Multiply")
	temp = changeMoney(temp,changeMoney(moneyPerSec,float(get_parent().get_parent().get_node("Shop").buildings[5][0])/3,"Multiply"),"Misc")
	
	var extraExpo = get_parent().get_parent().get_node("UpgradeTab/Second/Choice1").upgrades2[7][1]
	if int(extraExpo) > 1:
		temp = changeMoney(temp,pow(1000,int(extraExpo)),"Multiply")
	
	if !('e' in temp):
		temp = float(temp) - 1
		get_parent().get_node("Currency3").text = "%.2f" % float(temp) + " Flame / click"
	else:
		temp = getScientificNotation(temp).split('e')
		get_parent().get_node("Currency3").text = "%.2f" % float(temp[0]) + 'e' + temp[1] + " Flame / click"


func _on_Clicker_pressed():
	var temp = changeMoney(moneyPerClick,(1+float(get_parent().get_parent().get_node("Shop").buildings[4][0])/10),"Multiply")
	temp = changeMoney(temp,changeMoney(moneyPerSec,float(get_parent().get_parent().get_node("Shop").buildings[5][0])/3,"Multiply"),"Misc")
	if !('e' in temp):
		temp = float(temp) - 1
	
	var extraExpo = get_parent().get_parent().get_node("UpgradeTab/Second/Choice1").upgrades2[7][1]
	if int(extraExpo) > 1:
		temp = changeMoney(temp,pow(1000,int(extraExpo)),"Multiply")
	
	var crit = get_parent().get_parent().get_node("UpgradeTab/Second/Choice1").upgrades2[3][1]
	var random = rand_range(1,100)
	if int(random) <= int(crit):
		money = changeMoney(money,changeMoney(temp,100,"Multiply"),"Click")
		var temple = get_parent().get_parent().get_node("UpgradeTab/Second/Choice1").upgrades2[6][1]
		get_parent().get_parent().get_node("Shop").buildings[4][0] = changeMoney(get_parent().get_parent().get_node("Shop").buildings[4][0],temple,"Misc")
	else:
		money = changeMoney(money,temp,"Click")
	
	updateUI()
	pass


func _on_Timer_timeout():
	money = changeMoney(money, moneyPerSec,"Second")
	updateUI()
	pass

func _on_LongTimer_timeout():
	var extraAdder = get_parent().get_parent().get_node("UpgradeTab/Second/Choice1").upgrades2[2][1]
	if int(extraAdder) > 0:
		for _i in range(0,int(extraAdder)*4):
			_on_Clicker_pressed()
	var flintAdder = get_parent().get_parent().get_node("UpgradeTab/Second/Choice1").upgrades2[4][1]
	var shopNode = get_parent().get_parent().get_node("Shop")
	if int(flintAdder) > 0:
		shopNode.buildings[0][0] = changeMoney(shopNode.buildings[0][0], flintAdder, "Misc")
		shopNode.computePS()
		shopNode.updateUI()


func _on_LineEdit_text_entered(new_text):
	money = new_text
