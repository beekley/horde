extends Node

export(PackedScene) var mob_scene
export(PackedScene) var tower_scene

var towers_available: int = 1
var sites_claimed: int = 0

const TOWERS_PER_SITE: int = 3

func _ready():
	randomize()
	$MobTimer.start()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		print("left click", event.position)
		
		# Stop placing towers if none available.
		if towers_available <= 0:
			print("no towers left to place")
			return
		
		# Place tower where clicked
		var tower = tower_scene.instance()
		tower.connect("added_site", self, "add_site")
		tower.position = event.position
		add_child(tower)
		towers_available -= 1

func _on_MobTimer_timeout():
	# Spawn mobs proportional to number of sites.
	for i in range(sites_claimed):
		# Create a new instance of the Mob scene.
		var mob = mob_scene.instance()

		# Choose a random location on Path2D.
		var mob_spawn_location = get_node("MobSpawnPath/MobSpawnLocation")
		mob_spawn_location.offset = randi()

		# Set the mob's direction perpendicular to the path direction.
		var direction = mob_spawn_location.rotation + PI / 2

		# Set the mob's position to a random location.
		mob.position = mob_spawn_location.position
		mob.path = $Navigation2D.get_simple_path(mob.position, $TargetPoint.position)

		# Spawn the mob by adding it to the Main scene.
		add_child(mob)

func add_site() -> void:
	sites_claimed += 1
	towers_available += TOWERS_PER_SITE
