extends Node

class_name DialogueEvent

var pos
var tree
var timer

func _init(_pos,_tree):
	self.pos = _pos
	self.tree = _tree
	self.timer = DialogueSystem.typeTimer

func on_event():
	pass
