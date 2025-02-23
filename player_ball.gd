extends RigidBody3D

const JUMP_FORCE = 5.0
const TORQUE_FORCE = 5.0
const CAMERA_ROTATION_SPEED = 5.0
const CAMERA_DISTANCE = 5.0
const CAMERA_HEIGHT = 2.0

func is_on_floor() -> bool:
	return $ball_reference_position/ground_detection_area.get_overlapping_bodies().size() > 0

func _physics_process(delta: float) -> void:
	# La posición de referencia sigue la posición de la bola
	$ball_reference_position.position = position

	# Rotación de la cámara con Q y E
	if Input.is_action_pressed("rotate_camera_left"):
		$ball_reference_position.rotation.y += CAMERA_ROTATION_SPEED * delta
	if Input.is_action_pressed("rotate_camera_right"):
		$ball_reference_position.rotation.y -= CAMERA_ROTATION_SPEED * delta

	# Mantener la cámara siempre detrás de la bola
	var camera_offset = Vector3(0, CAMERA_HEIGHT, CAMERA_DISTANCE)
	var camera_position = $ball_reference_position.global_transform.origin - $ball_reference_position.basis.z * CAMERA_DISTANCE + Vector3.UP * CAMERA_HEIGHT
	$ball_reference_position/Camera3D.global_position = camera_position
	$ball_reference_position/Camera3D.look_at(global_position)

	# Dirección de movimiento basada en la rotación de la cámara
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

	# Normalizar dirección para evitar velocidades mayores en diagonal
	if movement_direction.length() > 0:
		movement_direction = movement_direction.normalized()

	# Rotar dirección de movimiento según la rotación de la cámara
	movement_direction = movement_direction.rotated(Vector3.UP, $ball_reference_position.rotation.y)

	# Aplicar torque para mover la bola
	apply_torque_impulse(movement_direction * TORQUE_FORCE * delta)
