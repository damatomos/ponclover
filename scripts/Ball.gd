extends Area2D

var velocity = Vector2(350, 0)

func _physics_process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	#rotation = velocity.angle()
