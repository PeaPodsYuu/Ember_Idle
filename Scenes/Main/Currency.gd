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
var _saveTimer = null

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
	updateUI()
	
	_timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(0.1)
	_timer.set_one_shot(false)
	_timer.start()

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
	get_parent().get_node("Currency2").text = getScientificNotation(moneyPerSec) + " Flame"


func _on_Clicker_pressed():
	money = changeMoney(money,moneyPerClick,"Click")
	updateUI()
	pass


func _on_Timer_timeout():
	money = changeMoney(money, moneyPerSec,"Second")
	updateUI()
	pass



func _on_LineEdit_text_entered(new_text):
	money = new_text
