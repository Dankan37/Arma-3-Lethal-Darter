class cfgAmmo {
	class G_40mm_HE;
	class G_40mm_Drone: G_40mm_HE {
		model = "\A3\Weapons_f\ammo\Handgrenade";

		indirectHit = 11;
		indirectHitRange = 9;
	};

	class Default;
	class TimeBombCore: Default{};
	class MineCore: TimeBombCore {};
	class MineBase: MineCore {};
	class ATMine_Range_Ammo: MineBase {};

	class LD_Colibri_Ammo: ATMine_Range_Ammo {
		model = "\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\UAV_backpack_F.p3d";
		defaultMagazine = "LD_Colibri_Mag";
		displayName = "AR-4 Colibri";
		hit = 10;
		armor = 0;
		explosive = 0;
		indirectHit = 0;
		indirectHitRange = 0;
		author = "Dankan37";
		mineCanBeReactivated = 0;
	};
};