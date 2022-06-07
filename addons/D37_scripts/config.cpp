#include "BIS_AddonInfo.hpp"
class cfgPatches 
{
    class D37_scripts
    {
        units[] = {"B_UAV_01_F_Armed","B_UAV_02_F_Mini"};
		weapons[] = {"ColibriMuzzle"};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Drones_F_Air_F_Gamma_UAV_01","A3_Weapons_F_Explosives"};
    };
};

#include "cfgFunctions.hpp"
#include "cfgVehicles.hpp"
#include "cfgAmmo.hpp"
#include "cfgMagazines.hpp"
#include "cfgWeapons.hpp"