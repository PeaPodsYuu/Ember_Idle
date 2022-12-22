extends Label

func _ready():
	self.hide()

func setText(search, index):
	var node = get_parent().get_parent().get_node(search)
	var buildingName
	
	if index == 0:
		buildingName = "Flint 'n' Steel"
	else:
		buildingName = "Placeholder"
	
	if int(node.upgrades[index][1]) < 5:
		var price = get_parent().get_parent().getScientificNotation(node.upgrades[index][0])
		if "e" in price:
			price = price.split("e")
			price =  "%.2f" % float(price[0]) + 'e' + price[1]
		self.text = "Upgrade " + buildingName + " to level " + String(int(node.upgrades[index][1])) + ", doubling the building's efficiency.\nPrice: " + price
	else:
		self.text = buildingName + " has reached it's final potential... for now."


func setMiscText(search, index):
	search = search.split(" ")[0]
	var info = int(get_parent().get_parent().get_node(search).clickUpgrades[index][1])
	
	if info == 0:
		if index == 0:
			self.text = "Upgrade your affinity to the Ember, incrementing your clicking base by 10 Flame per click.Cost: 625 Flame"
		if index == 1:
			self.text = "Brand yourself with the Ember's mark, incrementing your clicking base by 100 Flame per click.\nCost: 8500 Flame"
		if index == 2:
			self.text = "Join in on your fellow firestarters' more primitive ways of growing the ember.\nGain clicking power equal to the power of Flint 'n' Steel.\nCost: 50e3 Flame"
	else:
		self.text = "This upgrade has already been bought."

func setMiscText2(search, index):
	search = search.split(" ")[0]
	var info = int(get_parent().get_parent().get_node(search).upgrades2[index][1])
	
	if(info < 5):
		info = String(info)
		var price = get_parent().get_parent().getScientificNotation(get_parent().get_parent().get_node("Second/Choice1").upgrades2[index][0])
		if "e" in price:
			price = price.split("e")
			price =  "%.2f" % float(price[0]) + 'e' + price[1]
		if index == 0:
			self.text = "Channel your control over the Ember, doubling your profits for " + price + " Flame\nLevel: " + info + "/5"
		if index == 1:
			self.text = "Make use of the lesser, passive production, borrowing its energy tenfold and using it for yourself.\nPrice: " + price + " Flame\nLevel: " + info + "/5"
		if index == 2:
			self.text = "Wash your hands in ash left over by the flame, staying in touch with it even when not directly interacting with it.\nGain four times Flame per Click once every second passively. Every upgrade adds and extra x4 to this.\nPrice: " + price + " Flame\nLevel: " + info + "/5"
		if index == 3:
			self.text = "Everytime you bolster the flame, there is a 1% chance that your interaction is a hundred times stronger.\nEvery upgrade increases chance by 1%.\nPrice: " + price + " Flame\nLevel: " + info + "/5"
		if index == 4:
			self.text = "Create Flint 'n' Steel every second without raising it's price, thus ampliyfying your per click power as well!\nYou gain as many buildings per second as you possess levels of this upgrade.\nPrice: " + price + " Flame\nLevel: " + info + "/5"
		if index == 5:
			self.text = "Raise your passive production by 25% per upgrade level, by attuning yourself to the Ember.\nPrice: " + price + " Flame\nLevel: " + info + "/5"
		if index == 6:
			self.text = "Every critical strike will create one Temple of Flame.\nLeveling up this ability will create one extra temple per critical strike.\nPrice: " + price + " Flame\nLevel: " + info + "/5"
		if index == 7:
			self.text = "Unleash your power fully, attuning your "
			if int(info) == 0:
				self.text += "left arm"
			if int(info) == 1:
				self.text += "right arm"
			if int(info) == 2:
				self.text += "left leg"
			if int(info) == 3:
				self.text += "right leg"
			if int(info) == 4:
				self.text += "entire body"
			self.text += " with the flame, setting it on fire.\nThis will improve your clicking power by three whole exponents per upgrade.\nPrice: " + price + " Flame\nLevel: " + info + "/5"
	else:
		self.text = "You've already mastered this aspect of the Ember."

func setChoiceText(index):
	var choice = get_parent().get_parent().get_node("First").choice
	if choice == "0":
		if index == 0:
			self.text = "Refine your control over the unwieldy Ember, with plans to lead your people to prosperity.\nFrom now on, you swear that the fire will only grow at your command, rather than on its own.\nThis commitment will cost 50e5 Flame."
		if index == 1:
			self.text = "Allow the Ember to guide your movements, having it spread larger and brighter. What a beautiful sight!.\nFrom now on, you take the backseat and allow the flames to engulf as they will..\nThis commitment will cost 50e5 Flame.\n[NOT AVAILABLE IN DEMO, DO NOT CHOOSE]"
	else:
		self.text = "You've already made your choice.\nYou are the Ember's "
		if choice == "1":
			self.text += "Lawful Wielder."
		if choice == "2":
			self.text += "Dear Partner."

func _on_First_mouse_exited():
	get_parent().get_node("Main").show()
	self.hide()

func _on_Second_mouse_exited():
	get_parent().get_node("Main").show()
	self.hide()

func _on_Building1_mouse_entered():
	get_parent().get_node("Main").hide()
	setText("First",0)
	self.show()

func _on_Building2_mouse_entered():
	get_parent().get_node("Main").hide()
	setText("First",1)
	self.show()


func _on_Building3_mouse_entered():
	get_parent().get_node("Main").hide()
	setText("First",2)
	self.show()


func _on_Building4_mouse_entered():
	get_parent().get_node("Main").hide()
	setText("First",3)
	self.show()


func _on_Upgrade1_mouse_entered():
	get_parent().get_node("Main").hide()
	setMiscText("First",0)
	self.show()


func _on_Upgrade2_mouse_entered():
	get_parent().get_node("Main").hide()
	setMiscText("First",1)
	self.show()


func _on_Upgrade3_mouse_entered():
	get_parent().get_node("Main").hide()
	setMiscText("First",2)
	self.show()


func _on_Choice1_mouse_entered():
	get_parent().get_node("Main").hide()
	setChoiceText(0)
	self.show()


func _on_Choice2_mouse_entered():
	get_parent().get_node("Main").hide()
	setChoiceText(1)
	self.show()


func _on_Choice1A1_mouse_entered():
	get_parent().get_node("Main").hide()
	setMiscText2("Second/Choice1",0)
	self.show()


func _on_Choice1A2_mouse_entered():
	get_parent().get_node("Main").hide()
	setMiscText2("Second/Choice1",1)
	self.show()


func _on_Choice1A3_mouse_entered():
	get_parent().get_node("Main").hide()
	setMiscText2("Second/Choice1",2)
	self.show()


func _on_Choice1A4_mouse_entered():
	get_parent().get_node("Main").hide()
	setMiscText2("Second/Choice1",3)
	self.show()


func _on_Choice1A5_mouse_entered():
	get_parent().get_node("Main").hide()
	setMiscText2("Second/Choice1",4)
	self.show()


func _on_Choice1A6_mouse_entered():
	get_parent().get_node("Main").hide()
	setMiscText2("Second/Choice1",5)
	self.show()


func _on_Choice1A7_mouse_entered():
	get_parent().get_node("Main").hide()
	setMiscText2("Second/Choice1",6)
	self.show()


func _on_Choice1A8_mouse_entered():
	get_parent().get_node("Main").hide()
	setMiscText2("Second/Choice1",7)
	self.show()


func _on_Choice1A9_mouse_entered():
	get_parent().get_node("Main").hide()
	setMiscText2("Second/Choice1",8)
	self.show()
