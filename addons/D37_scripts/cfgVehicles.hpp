class CfgVehicles {
	class Air;
	class Helicopter_Base_F: Air {};
	class UAV_01_base_F: Helicopter_Base_F{
		class EventHandlers;
	};
	
	class B_UAV_01_F: UAV_01_base_F {
		class EventHandlers:EventHandlers {
			class lethalDarter {
				init = "[_this select 0] spawn D37_fnc_makeGrenadeDrone;";
			};
		};

		class assembleInfo;
	};

	class B_UAV_01_F_Armed: B_UAV_01_F {
		author = "Dankan37";
		displayName = "AR-2 Darter (Grenade)";

		class EventHandlers:EventHandlers {
			class lethalDarter {
				init = "[_this select 0] spawn D37_fnc_initDrone;";
			};
		};
	};

	class B_UAV_02_F_Mini: B_UAV_01_F {
		author = "Dankan37";
		displayName = "AR-4 Colibri";
		scope = 2;

		class EventHandlers:EventHandlers {
			class lethalDarter {
				init = "[_this select 0] spawn D37_fnc_setupColibri;";
			};
		};

		enableManualFire = 0;
		fuelCapacity = 10;
		hasGunner = -1;
		showgunneroptics = 0;

		class Turrets {};
		class assembleInfo: assembleInfo {
			dissasembleTo[] = {};
			primary = 0;
		};
	};
};
