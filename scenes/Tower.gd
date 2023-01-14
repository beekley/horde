extends Area2D

const Site = preload("res://scenes/Site.gd")

#func _on_Tower_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
#	# Index 0 is the tower area, which we can ignore.
#	if local_shape_index == 0:
#		return
#	# Index 1 is the range area, which we'll use to target mobs.
#	print(body, local_shape_index)
#	body.queue_free()

signal added_site

var has_checked_sites: bool = false
var line: Line2D

func _on_AttackTimer_timeout() -> void:
	# For some reason doing this in _ready didn't work, so we do it here.
	if !has_checked_sites:
		var tower_bodies = get_overlapping_bodies()
		for body in tower_bodies:
			var site: Site = body
			site.set_state(Site.State.CLAIMED)
			emit_signal("added_site")
		has_checked_sites = true
	# AttackArea is on layer 2 with Mobs.
	var target_bodies: Array = $AttackArea.get_overlapping_bodies()
	var target = target_bodies.pop_front()
	if target:
		if line:
			line.queue_free()
		line = Line2D.new()
		add_child(line)
		line.add_point(Vector2(0,0))
		line.add_point(target.position - position)
		
		target.queue_free()
