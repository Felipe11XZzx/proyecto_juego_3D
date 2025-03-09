extends RigidBody3D

const JUMP_FORCE = 10.0
const TORQUE_FORCE = 5.0
const CAMERA_ROTATION_SPEED = 5.0
const CAMERA_DISTANCE = 5.0
const CAMERA_HEIGHT = 2.0

func _ready() -> void:
	$ball_reference_position.rotation.y = $".".rotation.y
	
func is_on_floor():
	return $ball_reference_position / ground_detection_area.get_overlapping_bodies().size() > 1

func _physics_process(delta: float) -> void:
	$ball_reference_position.position = position

	if Input.is_action_pressed("rotate_camera_left"):
		$ball_reference_position.rotation.y += CAMERA_ROTATION_SPEED * delta
	if Input.is_action_pressed("rotate_camera_right"):
		$ball_reference_position.rotation.y -= CAMERA_ROTATION_SPEED * delta

	var camera_offset = Vector3(0, CAMERA_HEIGHT, CAMERA_DISTANCE)
	var camera_position = $ball_reference_position.global_transform.origin - $ball_reference_position.basis.z * CAMERA_DISTANCE + Vector3.UP * CAMERA_HEIGHT
	$ball_reference_position/Camera3D.global_position = camera_position
	$ball_reference_position/Camera3D.look_at(global_position)

	var movement_direction = Vector3.ZERO

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		linear_velocity.y = JUMP_FORCE
		
	if Input.is_action_pressed("move_left"):
		movement_direction.z -= 1
		
	if Input.is_action_pressed("move_right"):
		movement_direction.z += 1
		
	if Input.is_action_pressed("move_back"):
		movement_direction.x -= 1
		
	if Input.is_action_pressed("move_front"):
		movement_direction.x += 1

	if movement_direction.length() > 0:
		movement_direction = movement_direction.normalized()

	movement_direction = movement_direction.rotated(Vector3.UP, $ball_reference_position.rotation.y)
	apply_torque_impulse(movement_direction * TORQUE_FORCE * delta)
