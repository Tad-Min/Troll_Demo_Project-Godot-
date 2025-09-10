extends Node;

var unlocked_stages = [true, false, false];

#This function to unlock stage
func unlock_stage(stage_index: int):
	if stage_index < unlocked_stages.size():
		unlocked_stages[stage_index] = true;
	return;
	
# This function check stage unlocked	
func is_stage_unlocked(stage_index: int) -> bool:
	if stage_index < unlocked_stages.size():
		return unlocked_stages[stage_index];
	return false;
 
