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
	print("force: ", force_arrow)
	b.transform = self.global_transform
	b.velocity = b.transform.x * force_arrow * 1.2 * 10 #muzzle_velocity
	b.gravity = gravity

func _process(delta):
	#show()
	#update_trajectory(self.global_position, muzzle_velocity, gravity, delta)
	
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse_button_down:
		shoot()
		mouse_button_down = false
		#$Sprite2D.scale.x = 0.5
		$TextureProgressBar.value = 0
		force_arrow = 0
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#look_at(get_global_mouse_position())
		#print(clamp((distance - get_global_mouse_position()).y, -45, 45))
		#rotation_degrees = clamp((distance - get_global_mouse_position()).y, -90, 90)
		#position.direction_to(get_global_mouse_position())
		var moveY = (distance - get_global_mouse_position()).y
		var moveX = (distance - get_global_mouse_position()).x
		distance = get_global_mouse_position()
		if angle_arrow < 0 and moveY < 0:
			angle_arrow += 2
		elif angle_arrow > -90 and moveY > 0:
			angle_arrow -= 2
		rotation_degrees = angle_arrow
		
		if moveX < 0 and force_arrow >= 0:
			force_arrow -= 5
		elif moveX > 0 and force_arrow < 100:
			force_arrow += 5
		print("force: ", force_arrow)
			#$TextureProgressBar.value += 3
		
		$TextureProgressBar.value = (force_arrow / 100) * 100
		print(force_arrow)
		
		
func update_trajectory(dir: Vector2, speed: float, gravity: float, delta: float) -> void:
		var max_points = 8
		clear_points()
		var pos: Vector2 = Vector2.ZERO
		var vel = dir * speed
		for i in max_points:
			add_point(pos)
			vel.y += gravity * delta
			pos += vel * delta

func _input(event):
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			distance = get_global_mouse_position()
			#position = distance
			mouse_button_down = true
