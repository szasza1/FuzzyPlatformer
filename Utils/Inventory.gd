extends Node

class_name Inventory

const max_item:int = 5
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
	
	if item_count != 1:
		item.hide()

func use_item() -> void:
	pack[akt_index].action()
	
	if pack[akt_index].once_usable():
		pack[akt_index].hide()
		pack[akt_index].queue_free()
		
		
		if akt_index == (item_count - 1):
			akt_index = 0
			item_count -= 1
			pack[akt_index].show()
		else:
			var change_count:int =  item_count - (akt_index + 1)
			for index in range(akt_index, akt_index + change_count):
				pack[index] = pack[index+ 1]
			
			item_count -= 1
			pack[akt_index].show()


func next() -> void:
	pack[akt_index].hide()
	
	if (akt_index + 1) == item_count:
		akt_index = 0
	else:
		akt_index += 1
	
	pack[akt_index].show()


func prev() -> void:
	pack[akt_index].hide()
	
	if akt_index == 0:
		akt_index = item_count-1
	else:
		akt_index -= 1

	pack[akt_index].show()


func info() -> void:
	print("Item count: " + str(item_count))
	print("Akt index: " + str(akt_index))
