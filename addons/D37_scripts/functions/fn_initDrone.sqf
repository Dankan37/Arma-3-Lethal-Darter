//Spawns a drone with a grenade attached
_drone 		= param[0];
_grenade 	= param[1,"G_40mm_Drone"];
_name 		= param[2, "grenade"];

if(is3DEN) exitWith {};

//waitUntil {time > 0 and !is3DEN};
_gren = "G_40mm_Drone" createVehicle [0,0,1000];
_gren setVectorDirandUp [[0,0,-1],[0.1,0.1,1]]; 
_gren attachTo [_drone, [0,0,-0.12]]; 
_drone setVariable ["grenadeObj", _gren];

_ids = [];
{
	_n = _x addAction [("<t color='#FF0000'>" + "Drop " + _name + "</t>"), {
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
		} forEach crew _vehicle;
		
		//Given how things are setup the id can only be accessed later
		//_removeId = (_vehicle getVariable ["removeId",99]);

		//Bit of a complex code, we check every grenade type in the saved array and see if matches the one we dropped, then we remove the IDs associated with that grenade
		_found = false;
		_removeId = 99;
		_index = 0;
		_idArr = _vehicle getVariable ["_idArr", []];
		{
			_IDgrenade = (_x select 1);
			if(_IDgrenade == _grenadeType and !_found) then {
				_found = true; //TODO find function
				_removeId = (_x select 0);
				_idArr deleteAt _index;
			};
			_index = _index + 1;
		}forEach _idArr;

		
		_vehicle setVariable ["_idArr", _idArr];
		_vehicle removeAction _removeId;

		//Re initialize drone
		[_vehicle] call D37_fnc_makeGrenadeDrone;
	}, [_grenade], 10];

	_ids pushBack _n;
}forEach crew _drone;

_ids;
