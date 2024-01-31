extends RigidBody2D

#var velocity = Vector2(350, 0)

#var gravity = 680

var hit := false

func _ready():
	linear_velocity.x = 350
	$Timer.start(5)

func _process(delta):
	pass
		
	#print(linear_velocity)
	#linear_velocity.y += gravity * delta
	
	#move_and_slide()
	
	#velocity.y += gravity * delta
	#position += velocity * delta
	#rotation = velocity.angle() 


func _on_timer_timeout():
	if !hit:
		GameManager.total_lost += 1
	queue_free()
