/// scrP2RequestBackbuffer
var _world = instance_find(oP2World, 0);
surface_copy(_world.backbuffer, 0, 0, application_surface);
return _world.backbuffer;
