extends RigidBody2D

var speed = 100
var path = PoolVector2Array()
var destination: Vector2 = Vector2(0,0)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _ready():
	pass

func _process(delta):
	# Calculate the movement distance for this frame
	var distance_to_walk = speed * delta
	
	# Move the mob along the path until they have run out of movement or the path ends.
	while distance_to_walk > 0 and path.size() > 0:
		var distance_to_next_point = position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			# The mob does not have enough movement left to get to the next point.
			position += position.direction_to(path[0]) * distance_to_walk
		else:
			# The mob get to the next point
			position = path[0]
			path.remove(0)
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point
