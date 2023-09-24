class_name TrapType
enum Types {
	BOUNCER,
	TRAMPOLINE,
	PROPELLOR,
}

static func rand_type() -> Types:
	var rn := randi() % 3
	if rn == 0:
		return Types.BOUNCER
	elif rn == 1:
		return Types.TRAMPOLINE
	else:
		return Types.PROPELLOR