extends Label

var money = 0
var moneyPerClick = 1
var moneyPerSec = 0
var _timer = null



func _ready():
	updateUI()
	_timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(0.1)
	_timer.set_one_shot(false)
	_timer.start()
	pass 

func updateUI():
	text = str(money)+" Flame"

func _on_Clicker_pressed():
	money+=moneyPerClick
	updateUI()
	pass

func _on_Timer_timeout():
	money += float(moneyPerSec)/10
	updateUI()
	pass

func increment_Click(var incrementer):
	moneyPerClick += incrementer

func increment_Sec(var incrementer):
	moneyPerSec += incrementer
