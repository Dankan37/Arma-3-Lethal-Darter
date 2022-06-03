//Allows a grenade to be attached to a drone but doesn't spawn one

_drone = param[0];

_drone addAction ["Resupply drone", {
	params ["_target", "_caller", "_actionId", "_arguments"];

	_hasRGO = [_caller, 'MiniGrenade'] call BIS_fnc_hasItem;
	_hasRGN = [_caller, 'HandGrenade'] call BIS_fnc_hasItem;

	//MiniGrenade HandGrenade
	if(_hasRGO or _hasRGN) then {
		if(_hasRGO) then {
			_caller removeItem "MiniGrenade";
		} else {
			_caller removeItem "HandGrenade";
		};
		
		_target removeAction _actionId;
		[_target] call D37_fnc_initDrone;
	} else {
		_id = owner _caller;
		["You don't have any suitable grenade (RGO/RGN)"] remoteExec ["hint", _id];
	};
}, nil, 2, true, true, "", "!(_this in _target)", 5];