_mine 	= param[0];
_side 	= param[1, west];

//Position 
//_pos = position _mine;
_pos = _mine getRelPos [1, 0];

//create the new drone
_drone = "B_UAV_02_F_Mini" createVehicle _pos;
_crew = createVehicleCrew _drone;
(crew _drone) joinSilent (createGroup [_side, true]);

//This already runs in the drone init
//[_drone] spawn D37_fnc_setupColibri; 

//Delete the mine
deleteVehicle _mine;