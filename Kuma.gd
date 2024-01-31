extends CharacterBody2D


var SPEED = 8000.0
var can_change: bool = false
var finish_position: Vector2 = Vector2.ZERO
var start: Vector2 = Vector2.ZERO
var end: Vector2 = Vector2.ZERO
var rng = RandomNumberGenerator.new()
var stoped: bool = false

func _ready():
	var start_marker = $"../StartPointKuma2" as Marker2D
	var end_marker = $"../EndPointKuma" as Marker2D
	start = start_marker.global_position
	end = end_marker.global_position
	finish_position = Vector2(start.x, rng.randf_range(start.y, end.y))
	$Timer.start(0.5)
	position = start

func _physics_process(delta):
	
	velocity = position.direction_to(finish_position) * SPEED * delta
	move_and_slide()
	get_new_position(delta)

func get_new_position(delta: float):
	var value = clampf(finish_position.y, finish_position.y - (finish_position.y * delta), finish_position.y + (finish_position.y * delta))
	if (value + 1 >= position.y or position.y <= value - 1) and can_change:
		can_change = false
		print("entrou")
		finish_position = Vector2(start.x, rng.randf_range(start.y, end.y))
		$Timer.start(0.5)
	
	if (position.y + 1 >= end.y or end.y <= position.y - 1) and stoped:
		stoped = false
		position = end
		$Timer.start(3)
		SPEED = 8000

func _on_timer_timeout():
	can_change = true


func _on_area_2d_body_entered(body):
	if body.name == "Ball":
		$Timer.stop()
		can_change = false
		stoped = true
		finish_position = end
		SPEED = 16000
