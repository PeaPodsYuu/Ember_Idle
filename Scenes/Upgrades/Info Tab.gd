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

func setChoiceText(index):
	var choice = get_parent().get_parent().permission
	if choice == "0":
		if index == 0:
			self.text = "Refine your control over the unwieldy Ember, with plans to lead your people to prosperity.\nFrom now on, you swear that the fire will only grow at your command, rather than on its own.\nThis commitment will cost 10e6 Flame."
		if index == 1:
			self.text = "Allow the Ember to guide your movements, having it spread larger and brighter. What a beautiful sight!.\nFrom now on, you take the backseat and allow the flames to engulf as they will..\nThis commitment will cost 10e6 Flame."
	else:
		self.text = "You've already made your choice.\nYou are the Ember's "
		if choice == "1":
			self.text += "Lawful Wielder."
		if choice == "2":
			self.text += "Dear Partner."

func _on_First_mouse_exited():
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


func _on_Button_mouse_entered():
	pass # Replace with function body.
