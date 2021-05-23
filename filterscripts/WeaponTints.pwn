#include <a_samp>
#include <ZCMD>
#include <streamer>

#define 	MAX_WEPTINTS 	11

enum ePlayerInfo {

	p_iWepTints[MAX_WEPTINTS]
}
new PlayerInfo[MAX_PLAYERS][ePlayerInfo];

new iGunShopActor;

new iWeaponTints[6] = {
	0xFF4B5320, // Army
	0xFF9EAF43, // Green
	0xFFFFAE1A, // Orange
	0xFF0073E6, // LSPD
	0xFFFF1493, // Pink
	0xFFFFD700 // Gold
};

new Menu:iGunShopWeaponMenuID,
	Menu:iGunShopWeaponTintMenuID,
	bool:bPlayerInGunMenu[MAX_PLAYERS],
	pCurrentWeapon[MAX_PLAYERS];

public OnFilterScriptInit() {

	iGunShopActor = CreateActor(179, 295.5334,-40.5803,1001.5156, 0.0);

	iGunShopWeaponMenuID = CreateMenu("Weapon Tint Shop", 1, 20.0, 100.0, 200.0, 100.0);
	AddMenuItem(iGunShopWeaponMenuID, 0, "9MM Pistol");
	AddMenuItem(iGunShopWeaponMenuID, 0, "Silenced Pistol");
	AddMenuItem(iGunShopWeaponMenuID, 0, "Desert Eagle");
	AddMenuItem(iGunShopWeaponMenuID, 0, "Pump Shotgun");
	AddMenuItem(iGunShopWeaponMenuID, 0, "Combat Shotgun");
	AddMenuItem(iGunShopWeaponMenuID, 0, "UZI");
	AddMenuItem(iGunShopWeaponMenuID, 0, "MP5");
	AddMenuItem(iGunShopWeaponMenuID, 0, "AK47");
	AddMenuItem(iGunShopWeaponMenuID, 0, "M4");
	AddMenuItem(iGunShopWeaponMenuID, 0, "TEC-9");
	AddMenuItem(iGunShopWeaponMenuID, 0, "Rifle");

	iGunShopWeaponTintMenuID = CreateMenu("Weapon Tints", 1, 20.0, 100.0, 200.0, 100.0);
	AddMenuItem(iGunShopWeaponTintMenuID, 0, "Army Tint ($500.000)");
	AddMenuItem(iGunShopWeaponTintMenuID, 0, "Green Tint ($500.000)");
	AddMenuItem(iGunShopWeaponTintMenuID, 0, "Orange Tin ($500.000)t");
	AddMenuItem(iGunShopWeaponTintMenuID, 0, "LSPD Tint ($1.000.000)");
	AddMenuItem(iGunShopWeaponTintMenuID, 0, "Pink Tint ($1.000.000)");
	AddMenuItem(iGunShopWeaponTintMenuID, 0, "Gold Tint ($2.000.000)");
	return 1;
}

public OnFilterScriptExit() {

	DestroyActor(iGunShopActor);
	return 1;
}

public OnPlayerDisconnect(playerid, reason) {

	if(GetPlayerMenu(playerid) == iGunShopWeaponTintMenuID || GetPlayerMenu(playerid) == iGunShopWeaponMenuID) {
		DestroyDynamicObject(GetPVarInt(playerid, "GunShpObj"));
		DeletePVar(playerid, "GunShpSel0");
		DeletePVar(playerid, "GunShpSel1");
		DeletePVar(playerid, "GunShpObj");
		SetCameraBehindPlayer(playerid);
	}
	bPlayerInGunMenu[playerid] = false;
	return 1;
}
/*CMD:probar(playerid,params[]){
				SetPlayerCameraPos(playerid, 295.5854, -38.2358, 1002.2467);
				SetPlayerCameraLookAt(playerid, 295.5898, -39.2343, 1002.0201);
				new iObjectID = CreateDynamicObject(346, 295.46719, -39.79360, 1001.68970,   0.00000, 0.00000, 0.00000, .playerid = playerid);
				MoveDynamicObject(iObjectID, 295.47,-39.79360, 1001.68970, 0.0005, 0.0, 0.0, 180.0);
				Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
				SetPVarInt(playerid, "GunShpObj", iObjectID);
				ShowMenuForPlayer(iGunShopWeaponMenuID, playerid);
				bPlayerInGunMenu[playerid] = true;
				TogglePlayerControllable(playerid, false);
return 1;
}*/

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {

	if(newkeys & KEY_YES) {

		if(GetPlayerTargetActor(playerid) != INVALID_ACTOR_ID) {

			new iActorID = GetPlayerTargetActor(playerid);
			if(iActorID == iGunShopActor) {

				SetPlayerCameraPos(playerid, 295.5854, -38.2358, 1002.2467);
				SetPlayerCameraLookAt(playerid, 295.5898, -39.2343, 1002.0201);
				new iObjectID = CreateDynamicObject(346, 295.46719, -39.79360, 1001.68970,   0.00000, 0.00000, 0.00000, .playerid = playerid);
				MoveDynamicObject(iObjectID, 295.47,-39.79360, 1001.68970, 0.0005, 0.0, 0.0, 180.0);
				Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
				SetPVarInt(playerid, "GunShpObj", iObjectID);
				ShowMenuForPlayer(iGunShopWeaponMenuID, playerid);
				bPlayerInGunMenu[playerid] = true;
				TogglePlayerControllable(playerid, false);
			}
		}
	}
}

public OnPlayerUpdate(playerid) {

	new newkeys,
		updown,
		leftright;

	new pCurWeap = GetPlayerWeapon(playerid);
    if(pCurWeap != pCurrentWeapon[playerid]) {

        WepTint_OnPlayerChangeWeapon(playerid, pCurWeap);
		pCurrentWeapon[playerid] = pCurWeap;
    }

    GetPlayerKeys(playerid, newkeys, updown, leftright);
	if(updown == KEY_UP) {

		if(bPlayerInGunMenu[playerid]) {

			if(GetPlayerMenu(playerid) == iGunShopWeaponMenuID) {

				new iPMenuItem = GetPVarInt(playerid, "GunShpSel0"),
					iObjectID = GetPVarInt(playerid, "GunShpObj");

				if(iPMenuItem < 1) iPMenuItem = MAX_WEPTINTS;
				iPMenuItem--;

				DestroyDynamicObject(iObjectID);
				iObjectID = CreateDynamicObject(WepTint_GetWeaponObjectID(iPMenuItem), 295.46719, -39.79360, 1001.68970, 0.00000, 0.00000, 0.00000, .playerid = playerid);
				Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
				MoveDynamicObject(iObjectID, 295.47,-39.79360, 1001.68970, 0.0005, 0.0, 0.0, 180.0);
				SetPVarInt(playerid, "GunShpObj", iObjectID);
				SetPVarInt(playerid, "GunShpSel0", iPMenuItem);
			}
			else if(GetPlayerMenu(playerid) == iGunShopWeaponTintMenuID) {

				new iPMenuItem = GetPVarInt(playerid, "GunShpSel1"),
					iObjectID = GetPVarInt(playerid, "GunShpObj");

				if(iPMenuItem < 1) iPMenuItem = sizeof(iWeaponTints)-1;
				iPMenuItem--;

				DestroyDynamicObject(iObjectID);
				iObjectID = CreateDynamicObject(WepTint_GetWeaponObjectID(GetPVarInt(playerid, "GunShpSel0")), 295.46719, -39.79360, 1001.68970, 0.00000, 0.00000, 0.00000, .playerid = playerid);
				Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
				MoveDynamicObject(iObjectID, 295.47,-39.79360, 1001.68970, 0.0005, 0.0, 0.0, 180.0);
				SetPVarInt(playerid, "GunShpObj", iObjectID);
				SetPVarInt(playerid, "GunShpSel1", iPMenuItem);
			}
		}
	}
	if(updown == KEY_DOWN) {

		if(bPlayerInGunMenu[playerid]) {

			if(GetPlayerMenu(playerid) == iGunShopWeaponMenuID) {

				new iPMenuItem = GetPVarInt(playerid, "GunShpSel0"),
					iObjectID = GetPVarInt(playerid, "GunShpObj");

				if(iPMenuItem >= MAX_WEPTINTS-1) iPMenuItem = -1;
				iPMenuItem++;

				DestroyDynamicObject(iObjectID);
				iObjectID = CreateDynamicObject(WepTint_GetWeaponObjectID(iPMenuItem), 295.46719, -39.79360, 1001.68970, 0.00000, 0.00000, 0.00000, .playerid = playerid);
				Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
				MoveDynamicObject(iObjectID, 295.47,-39.79360, 1001.68970, 0.0005, 0.0, 0.0, 180.0);
				SetPVarInt(playerid, "GunShpObj", iObjectID);
				SetPVarInt(playerid, "GunShpSel0", iPMenuItem);
			}
			else if(GetPlayerMenu(playerid) == iGunShopWeaponTintMenuID) {

				new iPMenuItem = GetPVarInt(playerid, "GunShpSel1"),
					iObjectID = GetPVarInt(playerid, "GunShpObj");

				if(iPMenuItem >= sizeof(iWeaponTints)-1) iPMenuItem = -1;
				iPMenuItem++;

				DestroyDynamicObject(iObjectID);
				iObjectID = CreateDynamicObject(WepTint_GetWeaponObjectID(GetPVarInt(playerid, "GunShpSel0")), 295.46719, -39.79360, 1001.68970, 0.00000, 0.00000, 0.00000, .playerid = playerid);
				Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
				MoveDynamicObject(iObjectID, 295.47,-39.79360, 1001.68970, 0.0005, 0.0, 0.0, 180.0);
				SetPVarInt(playerid, "GunShpObj", iObjectID);
				SetPVarInt(playerid, "GunShpSel1", iPMenuItem);
			}
		}
	}
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row) {

	if(GetPlayerMenu(playerid) == iGunShopWeaponMenuID) {

		new iObjectID = GetPVarInt(playerid, "GunShpObj");
		DestroyDynamicObject(iObjectID);
		iObjectID = CreateDynamicObject(WepTint_GetWeaponObjectID(row), 295.46719, -39.79360, 1001.68970,   0.00000, 0.00000, 0.00000, .playerid = playerid);
		MoveDynamicObject(iObjectID, 295.47,-39.79360, 1001.68970, 0.0005, 0.0, 0.0, 180.0);
		Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
		SetPVarInt(playerid, "GunShpObj", iObjectID);
		SetPVarInt(playerid, "GunShpSel0", row);
		ShowMenuForPlayer(iGunShopWeaponTintMenuID, playerid);
		return 1;
	}
	if(GetPlayerMenu(playerid) == iGunShopWeaponTintMenuID) {

		SetPlayerWeaponPrint(playerid, WepTint_GetWeaponIDFromChoice(GetPVarInt(playerid, "GunShpSel0")), row);
		DestroyDynamicObject(GetPVarInt(playerid, "GunShpObj"));
		DeletePVar(playerid, "GunShpSel0");
		DeletePVar(playerid, "GunShpSel1");
		DeletePVar(playerid, "GunShpObj");
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, true);
		bPlayerInGunMenu[playerid] = false;
		return 1;
	}
	return 1;
}

public OnPlayerExitedMenu(playerid) {

	if(GetPlayerMenu(playerid) == iGunShopWeaponMenuID && !GetPVarType(playerid, "GunShpSel1")) {
		DestroyDynamicObject(GetPVarInt(playerid, "GunShpObj"));
		DeletePVar(playerid, "GunShpSel0");
		DeletePVar(playerid, "GunShpObj");
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, true);
		bPlayerInGunMenu[playerid] = false;
	}
	else if(GetPlayerMenu(playerid) == iGunShopWeaponTintMenuID) {
		DestroyDynamicObject(GetPVarInt(playerid, "GunShpObj"));
		DeletePVar(playerid, "GunShpSel0");
		DeletePVar(playerid, "GunShpSel1");
		DeletePVar(playerid, "GunShpObj");
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, true);
		bPlayerInGunMenu[playerid] = false;
	}
    return 1;
}

WepTint_GetWeaponObjectID(iChoiceID) {

	new iObjectID;
	switch(iChoiceID) {

		case 0: iObjectID = 346;
		case 1: iObjectID = 347;
		case 2: iObjectID = 348;
		case 3: iObjectID = 349;
		case 4: iObjectID = 351;
		case 5: iObjectID = 352;
		case 6: iObjectID = 353;
		case 7: iObjectID = 355;
		case 8: iObjectID = 356;
		case 9: iObjectID = 372;
		case 10: iObjectID = 357;
		case 11: iObjectID = 359;
		case 12: iObjectID = 360;
		case 13: iObjectID = 362;
	}
	return iObjectID;
}

WepTint_GetWeaponIDFromChoice(iChoiceID) {

	new iWeaponID;
	switch(iChoiceID) {

		case 0: iWeaponID = 22;
		case 1: iWeaponID = 23;
		case 2: iWeaponID = 24;
		case 3: iWeaponID = 25;
		case 4: iWeaponID = 27;
		case 5: iWeaponID = 28;
		case 6: iWeaponID = 29;
		case 7: iWeaponID = 30;
		case 8: iWeaponID = 31;
		case 9: iWeaponID = 32;
		case 10: iWeaponID = 33;
		case 11: iWeaponID = 35;
		case 12: iWeaponID = 36;
		case 13: iWeaponID = 38;
	}
	return iWeaponID;
}

WepTint_GetChoiceIDFromWeapon(iWeaponID) {

	new iChoiceID;
	switch(iWeaponID) {

		case 22: iChoiceID = 0;
		case 23: iChoiceID = 1;
		case 24: iChoiceID = 2;
		case 25: iChoiceID = 3;
		case 27: iChoiceID = 4;
		case 28: iChoiceID = 5;
		case 29: iChoiceID = 6;
		case 30: iChoiceID = 7;
		case 31: iChoiceID = 8;
		case 32: iChoiceID = 9;
		case 33: iChoiceID = 10;
		case 35: iChoiceID = 11;
		case 36: iChoiceID = 12;
		case 38: iChoiceID = 13;
		default: iChoiceID = 0;
	}
	return iChoiceID;
}

WepTint_OnPlayerChangeWeapon(playerid, newweapon) {

	RemovePlayerAttachedObject(playerid, 7);
	if(PlayerInfo[playerid][p_iWepTints][WepTint_GetChoiceIDFromWeapon(newweapon)]) {

		SetPlayerWeaponPrint(playerid, newweapon, PlayerInfo[playerid][p_iWepTints][WepTint_GetChoiceIDFromWeapon(newweapon)]);
	}
}

SetPlayerWeaponPrint(playerid, iWepID, iChoice) {

	switch(iWepID) {

		case 22: SetPlayerAttachedObject(playerid, 7, 346, 6, -0.004999, -0.003999, -0.006000, 0.000000, 0.000000, -1.800000, 1.007000, 1.337999, 1.069000, iWeaponTints[iChoice], iWeaponTints[iChoice]);
		case 23: SetPlayerAttachedObject(playerid, 7, 347, 6, -0.003999, -0.001999, -0.003999, 0.000000, 0.299999, -0.999999, 1.000000, 1.188000, 1.063000, iWeaponTints[iChoice], iWeaponTints[iChoice]);
		case 24: SetPlayerAttachedObject(playerid, 7, 348, 6, -0.006999, -0.004000, 0.002000, -1.600000, -0.200000, 0.400000, 1.019999, 1.146999, 1.027000, iWeaponTints[iChoice], iWeaponTints[iChoice]);
		case 25: SetPlayerAttachedObject(playerid, 7, 349, 6, 0.000000, -0.008999, -0.004000, 0.000000, 1.099999, 1.499999, 1.000000, 1.222000, 1.088000, iWeaponTints[iChoice], iWeaponTints[iChoice]);
		case 27: SetPlayerAttachedObject(playerid, 7, 351, 6, 0.003000, -0.014000, -0.003000, 0.000000, 0.000000, 2.199999, 1.000000, 1.371000, 1.023000, iWeaponTints[iChoice], iWeaponTints[iChoice]);
		case 28: SetPlayerAttachedObject(playerid, 7, 352, 6, -0.002000, -0.008000, -0.001999, -0.300000, 0.000000, 1.199999, 1.019999, 1.245000, 1.043000, iWeaponTints[iChoice], iWeaponTints[iChoice]);
		case 29: SetPlayerAttachedObject(playerid, 7, 353, 6, 0.000000, -0.009000, -0.009000, 0.000000, 0.099999, 2.100000, 1.000000, 1.290001, 1.053000, iWeaponTints[iChoice], iWeaponTints[iChoice]);
		case 30: SetPlayerAttachedObject(playerid, 7, 355, 6, 0.000000, -0.011000, 0.000000, 0.000000, 0.000000, 2.100000, 1.009000, 1.424000, 1.013000, iWeaponTints[iChoice], iWeaponTints[iChoice]);
		case 31: SetPlayerAttachedObject(playerid, 7, 356, 6, -0.002000, -0.005999, 0.001000, 0.000000, 0.899999, 1.699999, 0.997999, 1.318999, 1.088001, iWeaponTints[iChoice], iWeaponTints[iChoice]);
		case 32: SetPlayerAttachedObject(playerid, 7, 372, 6, -0.003000, -0.009000, -0.001999, 0.000000, 0.400000, 0.800000, 1.015000, 1.232000, 1.055000, iWeaponTints[iChoice], iWeaponTints[iChoice]);
		case 33: SetPlayerAttachedObject(playerid, 7, 357, 6, 0.000000, -0.015000, -0.001999, 0.000000, 1.200000, 2.199999, 1.000000, 1.286001, 1.096001, iWeaponTints[iChoice], iWeaponTints[iChoice]);
		case 35: SetPlayerAttachedObject(playerid, 7, 359, 6, 0.001999, -0.007000, -0.009000, 0.000000, -0.100000, 0.000000, 0.989999, 1.213001, 1.084001, iWeaponTints[iChoice], iWeaponTints[iChoice]);
		case 36: SetPlayerAttachedObject(playerid, 7, 360, 6, 0.001000, -0.004999, -0.008000, 0.000000, 0.000000, 0.000000, 1.000000, 1.140000, 1.055000, iWeaponTints[iChoice], iWeaponTints[iChoice]);
		case 38: SetPlayerAttachedObject(playerid, 7, 362, 6, -0.041000, 0.001999, 0.012000, 0.000000, 0.999999, -0.599999, 1.085000, 1.189999, 1.134000, iWeaponTints[iChoice], iWeaponTints[iChoice]);
		default: return 1;
	}
	GivePlayerWeapon(playerid, iWepID, 999999);
	PlayerInfo[playerid][p_iWepTints][WepTint_GetChoiceIDFromWeapon(iWepID)] = iChoice;
	return 1;
}
