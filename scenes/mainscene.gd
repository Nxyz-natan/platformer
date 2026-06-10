extends Node2D
var score: int = 0
var level: int = 1
@onready var scorelabel: Label = $HUD/score/scorelabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _setup_level() -> void:
	var exit = $".".get_node_or_null("Exit")
	if exit:
		exit.body_entered.connect(_on_exit_body_entered)
	#connect apples
	var apples = $".".get_node_or_null("apples")
	if apples:
		for apple in apples.get_children():
			apple.collected.connect(increase_score)
	#connect enemies
	var enemies = $".".get_node_or_null("enemy")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)
			
			

func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		level += 1
		body.can_move = false

func _on_player_died(body):
	body.die()
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
	print("Player Killed")


func increase_score() -> void:
	score +=1
	scorelabel.text = "SCORE : %s" % score
	
