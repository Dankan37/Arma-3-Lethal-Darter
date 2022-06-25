_drone = param[0];

if(!isServer) exitWith {};
//There is an issue with ACE where the drone is place with a mass of 5, this break everything and apparently setting the mass to 170 (AR2 drone) fixes everythind idk lol bohemia fix this
_drone setMass 170;
if(count crew _drone == 0) then {
	_list = _drone nearEntities ["Man", 4];
	_crew = createVehicleCrew _drone;

	_side = west;
	if(count _list > 0) then {
		_side = side selectRandom _list;;
	};
	(crew _drone) joinSilent (createGroup [_side, true]);
};

_drone addAction ["Disassemble drone", {
	params ["_target", "_caller", "_actionId", "_arguments"];

	_hasSpace = _caller canAdd "LD_Colibri_Mag";
	_id = owner _caller;

	if(_hasSpace) then {
		//If a grenade was attached, we remove it and take it back
		_grenadeType = _target getVariable ["grenadeType", ""];
		if(_grenadeType != "") then {
			_caller addItem _grenadeType;
			_grenade = _target getVariable ["grenadeObj", objNull];
			detach _grenade;
			deleteVehicle _grenade;
		};

		_target removeAction _actionId;
		deleteVehicle _target;
		_caller addItem "LD_Colibri_Mag";
		["The drone was disassembled and added to your inventory"] remoteExec ["hint", _id];
	} else {
		["You don't have enough space to carry this drone"] remoteExec ["hint", _id];
	};
}, nil, 1, false, true, "", "!(_this in _target) and (isTouchingGround _target) and (alive _target)", 3];

//Make it possible to attach grenades
[_drone] spawn D37_fnc_makeGrenadeDrone; 