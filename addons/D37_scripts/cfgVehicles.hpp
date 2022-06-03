//commanding = -1;
//configfile >> "CfgVehicles" >> "B_UAV_01_F" >> "Turrets" >> "MainTurret" >> "commanding"
//["UAV_01_base_F","Helicopter_Base_F","Helicopter","Air","AllVehicles","All"]
//"PilotCamera" >> "OpticsIn" >> "Wide"


class CfgVehicles {
	class Air;
	class Helicopter_Base_F: Air {};
	class UAV_01_base_F: Helicopter_Base_F{};
	
	class B_UAV_01_F: UAV_01_base_F {
		class EventHandlers;
	};
	class B_UAV_01_F_Armed: B_UAV_01_F {
		displayName = "AR-2 Darter (Grenade)";

		class EventHandlers:EventHandlers {
			init = "[_this select 0] spawn D37_fnc_initDrone;";
		}
	};
};
