extends Node

class_name Inventory

const max_item:int = 3
var pack:Array[Node] = []
var akt_index:int = 0
var item_count:int = 0
var inventory_node:Node

func _init(inventory:Node):
	inventory_node = inventory

func add_item(item:Node) -> void:
	if item_count < max_item:
		item_count += 1
		pack.append(item)
		inventory_node.add_child(item)


func use_item() -> void:
	pack[akt_index].action()


func next() -> void:
	if (akt_index + 1) == item_count:
		akt_index = 0
	else:
		akt_index += 1


func prev() -> void:
	if akt_index == 0:
		akt_index = item_count
	else:
		akt_index -= 1


func info() -> void:
	print("Item count: " + str(item_count))
	print("Akt index: " + str(akt_index))
