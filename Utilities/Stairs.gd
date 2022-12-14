extends Area2D

@export var destination : Vector2
@export var dir: String # (String, "Up", "Down")

func _ready():
	self.add_to_group("Stairs")

func _on_Stairs_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	call_deferred("transision")

func transision():
	$CollisionShape2D.disabled = true
	Global.game.room_transition(destination, dir)
	$CollisionShape2D.disabled = false
