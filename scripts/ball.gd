extends CharacterBody2D


var speed = 200
var dir = Vector2.DOWN
var is_active = true


func _ready() -> void:
	velocity = Vector2(speed * -1, speed)
	speed = speed + (20 * GameManager.level)
	
func _physics_process(delta: float) -> void:
	if is_active:
		
		var collision = move_and_collide(velocity * delta)
		
		if collision:
			velocity = velocity.bounce(collision.get_normal())
			
			if collision.get_collider().has_method("hit"):
				collision.get_collider().hit()

			if collision.get_collider().is_in_group("Bricks"):
				Engine.time_scale = 1
				
			if collision.get_collider().is_in_group("SlowMoPowerUp"):
				$SlowMo.start(1.0)
				Engine.time_scale = 0.5
				
			if collision.get_collider().is_in_group("Particle"):
				$trail.emitting = true
				Engine.time_scale = 1.5
			
		if(velocity.y > 0 and velocity.y < 100):
			velocity.y = -200
			
		if velocity.x == 0:
			velocity.x = -200 
	
	

func gameOver():
	GameManager.score = 0
	GameManager.level = 1
	get_tree().reload_current_scene()

func _on_deathzone_body_entered(body: Node2D) -> void:
	gameOver()
