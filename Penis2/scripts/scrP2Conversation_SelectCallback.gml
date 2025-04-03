/// scrP2Conversation_SelectCallback
var options_inst = argument0, ind = argument1, selection = argument2;
var _conversation = instance_find(objP2Conversation, 0);
scrP2ConversationGoto(_conversation, options_inst.options[options_inst._option_index]);
