extends CanvasLayer
@onready var total_win := $TotalWin/HBoxContainer/Label as Label
@onready var total_lost := $TotalLost/HBoxContainer/Label as Label

# Called when the node enters the scene tree for the first time.
func _ready():
	update_ui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_ui()
func update_ui():
	total_win.text = str(GameManager.total_win)
	total_lost.text = str(GameManager.total_lost)
