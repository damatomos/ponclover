extends Node2D

var pointer_position: Vector2 = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#$Pointer.global_position = pointer_position


func _on_player_last_position_pointer(pos):
	print("Position: ", pos)
	#pointer_position = pos


func _on_cesta_body_entered(body):
	print(body)
	
	if body.name == "Ball":
		GameManager.total_win += 1
		body.hit = true
