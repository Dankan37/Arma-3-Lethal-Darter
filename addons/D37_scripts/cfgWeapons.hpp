class cfgWeapons {
	class Put {
		class MineMuzzle;
		class ColibriMuzzle: MineMuzzle {
			magazines[] = {"LD_Colibri_Mag"};
			class EventHandlers {
				fired = "[(_this select 6), side (_this select 0)] spawn D37_fnc_initColibri;";
			};
		};
		muzzles[] += {"ColibriMuzzle"};
	};
};
