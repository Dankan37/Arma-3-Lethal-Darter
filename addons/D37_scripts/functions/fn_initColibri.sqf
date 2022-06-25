_mine 	= param[0];
_side 	= param[1, west];

if(!isServer) exitWith {};

//Position 
_pos = getPosASL _mine;

//Spawn the drone
_drone = createVehicle ["B_UAV_02_F_Mini", _pos, [], 0, "NONE"];
_drone setPosASL _pos;
_crew = createVehicleCrew _drone;
(crew _drone) joinSilent (createGroup [_side, true]);

//Delete the mine
deleteVehicle _mine;