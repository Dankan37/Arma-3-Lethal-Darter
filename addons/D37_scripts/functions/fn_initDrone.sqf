//Spawns a drone with a grenade attached

_drone = param[0];

//Cheesy way to make this code run only when the mission has started
waitUntil {time > 0};
_gren = "G_40mm_Drone" createVehicle [0,0,1000];
_gren setVectorDirandUp [[0,0,-1],[0.1,0.1,1]]; 
_gren attachTo [_drone, [0,0,-0.12]]; 

{
	_x addAction ["Drop bomb", {
		//HandGrenade
		params ["_target", "_caller", "_actionId", "_arguments"];
		_vehicle = vehicle _caller;

		_gren = _vehicle getVariable ["grenade", objNull];
		detach _gren;
		deleteVehicle _gren;

		_droneVelocity = velocity _vehicle;

		_pos = _target modelToWorld [0,0,-0.12];
		_gren = "G_40mm_Drone" createvehicle _pos;
		_gren setVectorDirandUp [[0,0,-1],[0.1,0.1,1]]; 
		_gren setVelocity [_droneVelocity select 0, _droneVelocity select 1,-1];

		
		{
			_x removeAction _actionId;
		} forEach [gunner _vehicle, driver _vehicle];
		
		[_vehicle] call D37_fnc_makeGrenadeDrone;
	}];
}forEach [gunner _drone, driver _drone];

