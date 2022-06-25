//Allows a grenade to be attached to a drone but doesn't spawn one
_drone = param[0];
_number = param[1,1];

_drone addEventHandler ["Disassembled", {
	params ["_entity", "_primaryBag", "_secondaryBag"];
	removeAllActions _entity;
}];

//Loop for multiple grenades
for "_j" from 1 to _number do {
	_dropId = _drone addAction ["<t color='#FF0000'>Attach grenade</t>", {
		params ["_target", "_caller", "_actionId", "_arguments"];

		_owner = owner _caller;
		_throwables = (currentThrowable _caller);
		if((count _throwables) == 0) then {
			["No grenades found"] remoteExec ["hint", _owner];
		} else {
			//Pick current gren
			_selectedGrenade = _throwables select 0;
			_backupGrenade = _selectedGrenade;

			//Remove item
			_caller removeItem _selectedGrenade;
			_selectedGrenade = getText(configfile >> "CfgMagazines" >> _selectedGrenade >> "ammo");
			_name = getText(configfile >> "CfgMagazines" >> _backupGrenade >> "displayName");

			//Let me know
			["You attached a: " + _name] remoteExec ["hint", _owner];

			//RGO and RGN grenades have special treatment
			if((_selectedGrenade == "mini_Grenade") or (_selectedGrenade == "GrenadeHand")) then {
				_selectedGrenade = "G_40mm_Drone";
			};

			//Manage actions
			_target removeAction _actionId;
			_ids = [_target, _selectedGrenade, _name] call D37_fnc_initDrone;


			//Want your stuff back?
			_removeId = _target addAction [("<t color='#00FF00'>" + "Detach " + _name + "</t>"), {
				params ["_target", "_caller", "_actionId", "_arguments"];
				_grenadeType = 	(_this select 3) select 0;
				_Ids = 			(_this select 3) select 1;
				_name = 		(_this select 3) select 2;

				_i = 0;
				{
					_x removeAction (_Ids select _i);
					_i = (_i + 1);
				}forEach crew _target;

				//Give player his stuff back
				_caller addItem _grenadeType;
				//Let me know
				_owner = owner _caller;
				["You detached a: " + _name] remoteExec ["hint", _owner];

				//detach old grenade
				_oldGren = (attachedObjects _target) select 0;
				if(!isNil "_oldGren") then {
					detach _oldGren;
					deleteVehicle _oldGren;
				};

				//Remove detach action
				_target removeAction _actionId;

				//Reinitialize drone
				[_target] call D37_fnc_makeGrenadeDrone;
			}, [_backupGrenade, _ids, _name],  9, true, true, "", "!(_this in _target) and (alive _target)", 3];

			//Save everything for later
			_pushArray = [_removeId, _selectedGrenade];

			//Add the ids to the list
			_idArr = _target getVariable ["_idArr", []];
			_idArr pushBack _pushArray;
			_target setVariable ["_idArr", _idArr];

			//Grenade type
			_target setVariable ["grenadeType", _backupGrenade];
			//_target setVariable ["removeId", _removeId];
		};
	}, nil, 10, true, true, "", "!(_this in _target) and (alive _target)", 3];
};


[_drone] spawn {
	_drone = _this select 0;
	waitUntil {!alive _drone};
	_actions = removeAllActions _drone;
};