extends Line2D

var queue: Array

@export_range(0, 100, 1) var MAX_LENGTH: int

func _process(delta: float) -> void:
	queue.push_front(get_parent().global_position)
	
	if (queue.size() > MAX_LENGTH):
		queue.pop_back()
		
	clear_points()
	
	for point in queue:
		add_point(point)
	
	
	
