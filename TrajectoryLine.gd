extends Line2D

@onready var Ball = preload("res://prefabs/ball.tscn")

@export var muzzle_velocity = 1000
@export var gravity = 680 #980

var distance: Vector2 = Vector2.ZERO

var mouse_button_down: bool = false
var angle_arrow: float = 0
var force_arrow: float = 0

func _ready():
	rotation_degrees = 0

func shoot():
	var b = Ball.instantiate()
	owner.add_child(b)
	b.transform = $Arrow.global_transform
	b.velocity = b.transform.x * force_arrow * 1.2 * 10 #muzzle_velocity
	b.gravity = gravity

func _process(delta):
	#show()
	
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse_button_down:
		shoot()
		mouse_button_down = false
		$Arrow/TextureProgressBar.value = 0
		force_arrow = 0
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		update_trajectory(delta)
		var moveY = (distance - get_global_mouse_position()).y
		var moveX = (distance - get_global_mouse_position()).x
		distance = get_global_mouse_position()
		if angle_arrow < 0 and moveY < 0:
			angle_arrow += 2
		elif angle_arrow > -90 and moveY > 0:
			angle_arrow -= 2
		#rotation_degrees = angle_arrow
		$Arrow.rotation_degrees = angle_arrow
		if moveX < 0 and force_arrow >= 0:
			force_arrow -= 1.5
		elif moveX > 0 and force_arrow < 100:
			force_arrow += 1.5
		
		$Arrow/TextureProgressBar.value = (force_arrow / 100) * 100
		
func update_trajectory(delta: float) -> void:
		var vel: Vector2 = $Arrow.global_transform.x * force_arrow * 1.2 * 10
		var num_of_points = 100.0
		clear_points()
		var pos = Vector2.ZERO
		for point in num_of_points:
			vel.y += gravity * delta
			pos += vel * delta
			add_point(pos)

func _input(event):
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			distance = get_global_mouse_position()
			mouse_button_down = true
