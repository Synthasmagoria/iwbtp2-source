/// scrP2PushOutBlockInternalSet(_blocked)
var _blocked = argument0;

blocked = _blocked;
image_index = _blocked;

if (_blocked) {
    if (!instance_exists(block)) {
        block = instance_create(x, y, objBlock);
        instance_set_width(block, sprite_width);
        instance_set_height(block, sprite_height);
    }
    
    if (place_meeting(x, y, objPlayer)) {
        scrP2PushOutBlockQueueEffect(id);
    }
} else {
    if instance_exists(block) {
        instance_destroy(block);
        block = noone;
    }
}
