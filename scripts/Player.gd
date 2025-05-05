extends CharacterBody2D

@export var jump_force: float = 600.0
@export var gravity: float = 1200.0

var is_charging = false
var charge_power = 0.0
var max_charge = 1.5
var charge_rate = 1.0
var can_double_jump = true
var has_jumped = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		can_double_jump = true
		has_jumped = false

	if Input.is_action_pressed("jump"):
		is_charging = true
		charge_power = min(charge_power + delta * charge_rate, max_charge)
	elif is_charging:
		velocity.y = -jump_force * charge_power
		charge_power = 0
		is_charging = false
		has_jumped = true
	elif Input.is_action_just_pressed("double_jump") and can_double_jump and has_jumped:
		velocity.y = -jump_force * 0.8
		can_double_jump = false

	move_and_slide()
