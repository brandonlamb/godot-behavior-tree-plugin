extends "res://addons/godot-behavior-tree-plugin/bt_base.gd"

const BehvError = preload("res://addons/godot-behavior-tree-plugin/error.gd")

var last_result = FAILED
var last_child_index = 0

# Composite Node
func tick(tick):
	var early_bail = false

	for idx in range(last_child_index, get_child_count()):
		var child = get_child(idx)

		last_child_index = idx

		last_result = child.tick(tick)

		if typeof(last_result) == TYPE_OBJECT and last_result extends BehvError:
			break

		if last_result == FAILED:
			break

		if last_result == ERR_BUSY:
			early_bail = true
			break

	if not early_bail or last_child_index == get_child_count() - 1:
		last_child_index = 0

	return last_result
