/// scrP2WorldDelayedExecution
var seconds = argument0, script = argument1;
with (oP2World) {
    var _variable_name = "delay_" + string(irandom(10000000));
    variable_instance_set(id, _variable_name, 0);
    TweenAddCallback(TweenFire(id, EaseLinear, 0, true, 0, seconds, _variable_name, 0, 1), TWEEN_EV_FINISH, id, script);
}
