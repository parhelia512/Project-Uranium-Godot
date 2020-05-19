extends Area2D

export var destination = Vector2()
export var dir = ""

func _on_Stairs_area_shape_entered(area_id, area, area_shape, self_shape):
	call_deferred("transision")

func transision():
	$CollisionShape2D.disabled = true
	Global.game.room_transition(destination, dir)
	$CollisionShape2D.disabled = false
