//Spawns a drone with a grenade attached
_drone = param[0];
_grenade = param[1,"G_40mm_Drone"];

//RGO and RGN grenades have special treatment
if((_grenade == "mini_Grenade") or (_grenade == "GrenadeHand")) then {
	_grenade = "G_40mm_Drone";
};

//Cheesy way to make this code run only when the mission has started
//waitUntil {time > 0 and !is3DEN};
_gren = "G_40mm_Drone" createVehicle [0,0,1000];
_gren setVectorDirandUp [[0,0,-1],[0.1,0.1,1]]; 
_gren attachTo [_drone, [0,0,-0.12]]; 
_drone setVariable ["grenadeObj", _gren];

_ids = [];
{
	_n = _x addAction ["Drop bomb", {
		//HandGrenade
		params ["_target", "_caller", "_actionId", "_arguments"];
		_vehicle = vehicle _caller;

		//detach old grenade
		_oldGren = (attachedObjects _target) select 0;
		if(!isNil "_oldGren") then {
			detach _oldGren;
			deleteVehicle _oldGren;
		};

		_droneVelocity = velocity _vehicle;
		_grenadeType = (_this select 3) select 0;

		_pos = _target modelToWorld [0,0,-0.2];
		_gren = _grenadeType createvehicle _pos;
		_gren setVectorDirandUp [[0,0,-1],[0.1,0.1,1]]; 
		_gren setVelocity [_droneVelocity select 0, _droneVelocity select 1, (_droneVelocity select 2) - 1];
		_vehicle setVariable ["grenadeType", ""];
		_vehicle setVariable ["grenadeObj", objNull];
		
		{
			_x removeAction _actionId;
		} forEach [gunner _vehicle, driver _vehicle];
		
		//Given how things are setup the id can only be accessed later
		_removeId = (_vehicle getVariable ["removeId",99]);
		_vehicle removeAction _removeId;

		//Re initialize drone
		[_vehicle] call D37_fnc_makeGrenadeDrone;
	}, [_grenade]];

	_ids pushBack _n;
}forEach [gunner _drone, driver _drone];

_ids;
