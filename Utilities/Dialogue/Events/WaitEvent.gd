extends "res://Utilities/Dialogue/Event.gd"

# This event pauses the text for the specified durations in seconds
class_name WaitEvent

var time

func _init(_pos,_tree,_time):
	self.time = _time

func on_event():
	timer.stop()
	await tree.create_timer(time).timeout
	timer.start()
