class cfgMagazines {
	//configfile >> "CfgMagazines" >> "ATMine_Range_Mag"
	//["CA_Magazine","Default"]
	class Default;
	class CA_Magazine: Default {};
	class ATMine_Range_Mag: CA_Magazine {};

	class LD_Colibri_Mag: ATMine_Range_Mag {
		picture = "\A3\Drones_F\Air_F_Gamma\UAV_01\Data\UI\UAV_01_CA.paa";
		model = "\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\UAV_backpack_F.p3d";
		ammo = "LD_Colibri_Ammo";
		descriptionShort = "PLACEHOLDER";
		displayName = "AR-4 Colibri";
		author = "Dankan37";
		mass = 80;
	};
};