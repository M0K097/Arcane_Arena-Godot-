extends Enemy

@onready var controller = $SkeletonController

func _ready():
	controller.connect_to(self)
