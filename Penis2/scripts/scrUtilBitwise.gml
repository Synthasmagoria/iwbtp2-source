#define scrUtilBitwise
return undefined;

#define int_create_mask
///int_create_mask(ind, len)
// Creates a mask to be used for bitwise operations
return ~(~0 << argument[1]) << argument[0];

#define int_read_bits
///int_read_bits(int, ind, num)
// Reads specified bits out of an integer value
return argument[0] >> argument[1] & int_create_mask(0, argument[2]);    

#define int_read_bit
///int_read_bit(int, ind)
// Reads a bit in an integer
return (argument[0] & (1 << argument[1])) != 0;

#define int_truth_bit
///int_truth_bit(int, ind)
// Set a bit in an int to true
return argument[0] | (1 << argument[1]);

#define int_flip_bits
///int_flip_bits(int, ind, num)
// Flips all selected bits in an int
return argument[0] ^ int_create_mask(argument[1], argument[2]);

#define int_set_bits
///int_set_bits(int, ind, num, val)
// Sets a set of bits in an integer
return (argument[0] & ~int_create_mask(argument[1], argument[2])) | argument[3] << argument[1];

#define int_set_bit
///int_set_bit(int, ind, bool)
return (argument0 & (~(1 << argument1))) | (argument2 << argument1);

#define int_get_bit
///int_get_bit(int, ind)
return (argument0 >> argument1) & 1;