extends Enemy

@onready var animation = $AnimatedSprite2D

func _ready():
	animation.flip_h = true
	animation.play()

func _process(_delta: float) -> void:
	look_at(target.position)
