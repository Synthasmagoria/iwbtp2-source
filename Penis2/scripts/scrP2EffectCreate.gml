/// scrSynthSequenceEffectCreate(object, delay, script, end_type, ...)
var object = argument[0], delay = argument[1], script = argument[2], end_type = argument[3];
var _effect = instance_create(0, 0, objSynthEffect);
_effect.object = object;
_effect.delay = delay;
_effect.script = script;
_effect.end_type = end_type;

if (argument_count > 4)
    _effect.duration = argument[4];

if (argument_count > 5)
    _effect.destroy = argument[5];

return _effect;
