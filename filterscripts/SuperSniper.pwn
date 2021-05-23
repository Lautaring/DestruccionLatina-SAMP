///////////////////////////////  Super Sniper by Yusei ///////////////////

#include <a_samp>

new Text:ss0;
new Text:ss1;
new Text:ss2;
new Text:ss3;
new Text:ss4;
new Text:ss5;
new Text:ss6;
new Text:ss7;
new Text:ss8;
new Text:ss9;
new Text:ss10;
new Text:ss11;
new Text:ss12;
new Text:ss13;
new Text:ss14;

new IsUsingSuperSniper[MAX_PLAYERS];


public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Super Sniper Ball by YUSEI FUDO");
	print("--------------------------------------\n");

	///    text draws ///
	ss0 = TextDrawCreate(57.500000, 193.199996, "LD_SPAC:white");
	TextDrawLetterSize(ss0, 0.000000, 0.000000);
	TextDrawTextSize(ss0, 160.000000, 96.320022);
	TextDrawAlignment(ss0, 1);
	TextDrawColor(ss0, -1061109505);
	TextDrawSetShadow(ss0, 0);
	TextDrawSetOutline(ss0, 0);
	TextDrawFont(ss0, 4);

	ss1 = TextDrawCreate(218.500000, 195.820007, "usebox");
	TextDrawLetterSize(ss1, 0.000000, 10.012221);
	TextDrawTextSize(ss1, 56.000000, 0.000000);
	TextDrawAlignment(ss1, 1);
	TextDrawColor(ss1, 0);
	TextDrawUseBox(ss1, true);
	TextDrawBoxColor(ss1, 102);
	TextDrawSetShadow(ss1, 0);
	TextDrawSetOutline(ss1, 0);
	TextDrawFont(ss1, 0);

	ss2 = TextDrawCreate(217.000000, 196.380004, "usebox");
	TextDrawLetterSize(ss2, 0.000000, 9.887777);
	TextDrawTextSize(ss2, 57.500000, 0.000000);
	TextDrawAlignment(ss2, 1);
	TextDrawColor(ss2, 0);
	TextDrawUseBox(ss2, true);
	TextDrawBoxColor(ss2, 102);
	TextDrawSetShadow(ss2, 0);
	TextDrawSetOutline(ss2, 0);
	TextDrawFont(ss2, 3);

	ss3 = TextDrawCreate(76.500000, 171.919982, "Super Sniper");
	TextDrawLetterSize(ss3, 0.723499, 3.016800);
	TextDrawAlignment(ss3, 1);
	TextDrawColor(ss3, 65535);
	TextDrawSetShadow(ss3, 0);
	TextDrawSetOutline(ss3, 1);
	TextDrawBackgroundColor(ss3, 51);
	TextDrawFont(ss3, 0);
	TextDrawSetProportional(ss3, 1);

	ss4 = TextDrawCreate(61.500000, 209.440078, "priCe :");
	TextDrawLetterSize(ss4, 0.449999, 1.600000);
	TextDrawAlignment(ss4, 1);
	TextDrawColor(ss4, -1);
	TextDrawSetShadow(ss4, 0);
	TextDrawSetOutline(ss4, 1);
	TextDrawBackgroundColor(ss4, 51);
	TextDrawFont(ss4, 2);
	TextDrawSetProportional(ss4, 1);

	ss5 = TextDrawCreate(141.000000, 211.120101, "5000 $");
	TextDrawLetterSize(ss5, 0.449999, 1.600000);
	TextDrawAlignment(ss5, 1);
	TextDrawColor(ss5, -2147450625);
	TextDrawSetShadow(ss5, 0);
	TextDrawSetOutline(ss5, 1);
	TextDrawBackgroundColor(ss5, 51);
	TextDrawFont(ss5, 1);
	TextDrawSetProportional(ss5, 1);

	ss6 = TextDrawCreate(60.000000, 235.760131, "Ammo :");
	TextDrawLetterSize(ss6, 0.449999, 1.600000);
	TextDrawAlignment(ss6, 1);
	TextDrawColor(ss6, -1);
	TextDrawSetShadow(ss6, 0);
	TextDrawSetOutline(ss6, 1);
	TextDrawBackgroundColor(ss6, 51);
	TextDrawFont(ss6, 2);
	TextDrawSetProportional(ss6, 1);

	ss7 = TextDrawCreate(141.000000, 236.320007, "30");
	TextDrawLetterSize(ss7, 0.449999, 1.600000);
	TextDrawAlignment(ss7, 1);
	TextDrawColor(ss7, -2147450625);
	TextDrawSetShadow(ss7, 0);
	TextDrawSetOutline(ss7, 1);
	TextDrawBackgroundColor(ss7, 51);
	TextDrawFont(ss7, 1);
	TextDrawSetProportional(ss7, 1);

	ss8 = TextDrawCreate(157.000000, 269.920013, "LD_SPAC:white");
	TextDrawLetterSize(ss8, 0.000000, 0.000000);
	TextDrawTextSize(ss8, 53.500000, 15.119995);
	TextDrawAlignment(ss8, 1);
	TextDrawColor(ss8, -1);
	TextDrawSetShadow(ss8, 0);
	TextDrawSetOutline(ss8, 0);
	TextDrawFont(ss8, 4);

	ss9 = TextDrawCreate(211.000000, 272.540008, "usebox");
	TextDrawLetterSize(ss9, 0.000000, 1.052219);
	TextDrawTextSize(ss9, 156.000000, 0.000000);
	TextDrawAlignment(ss9, 1);
	TextDrawColor(ss9, 0);
	TextDrawUseBox(ss9, true);
	TextDrawBoxColor(ss9, 102);
	TextDrawSetShadow(ss9, 0);
	TextDrawSetOutline(ss9, 0);
	TextDrawFont(ss9, 0);

	ss10 = TextDrawCreate(210.000000, 273.100006, "usebox");
	TextDrawLetterSize(ss10, 0.000000, 0.865553);
	TextDrawTextSize(ss10, 157.000000, 0.000000);
	TextDrawAlignment(ss10, 1);
	TextDrawColor(ss10, 0);
	TextDrawUseBox(ss10, true);
	TextDrawBoxColor(ss10, 102);
	TextDrawSetShadow(ss10, 0);
	TextDrawSetOutline(ss10, 0);
	TextDrawFont(ss10, 0);

	ss11 = TextDrawCreate(164.500000, 268.240051, "Buy");
	TextDrawLetterSize(ss11, 0.629999, 1.672799);
	TextDrawAlignment(ss11, 1);
	TextDrawColor(ss11, 16711935);
	TextDrawSetShadow(ss11, 0);
	TextDrawSetOutline(ss11, 1);
	TextDrawBackgroundColor(ss11, 51);
	TextDrawFont(ss11, 1);
	TextDrawSetProportional(ss11, 1);
	TextDrawSetSelectable(ss11, true);

	ss12 = TextDrawCreate(216.000000, 196.940002, "usebox");
	TextDrawLetterSize(ss12, 0.000000, 0.616667);
	TextDrawTextSize(ss12, 202.500000, 0.000000);
	TextDrawAlignment(ss12, 1);
	TextDrawColor(ss12, 0);
	TextDrawUseBox(ss12, true);
	TextDrawBoxColor(ss12, 102);
	TextDrawSetShadow(ss12, 0);
	TextDrawSetOutline(ss12, 0);
	TextDrawFont(ss12, 0);

	ss13 = TextDrawCreate(215.000000, 197.500000, "usebox");
	TextDrawLetterSize(ss13, 0.000000, 0.430000);
	TextDrawTextSize(ss13, 203.500000, 0.000000);
	TextDrawAlignment(ss13, 1);
	TextDrawColor(ss13, 0);
	TextDrawUseBox(ss13, true);
	TextDrawBoxColor(ss13, 102);
	TextDrawSetShadow(ss13, 0);
	TextDrawSetOutline(ss13, 0);
	TextDrawFont(ss13, 0);

	ss14 = TextDrawCreate(205.000000, 194.320007, "X");
	TextDrawLetterSize(ss14, 0.358500, 1.056800);
	TextDrawAlignment(ss14, 1);
	TextDrawColor(ss14, -16776961);
	TextDrawSetShadow(ss14, 0);
	TextDrawSetOutline(ss14, 1);
	TextDrawBackgroundColor(ss14, 51);
	TextDrawFont(ss14, 1);
	TextDrawSetProportional(ss14, 1);
	TextDrawSetSelectable(ss14, true);


	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}


main()
{
	print("\n----------------------------------");
	print(" SUpere Sniper = ON");
	print("----------------------------------\n");
}



public OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp(cmdtext, "/buyss", true, 5))
    {
    	ShowPlayerSuperSniperMenu(playerid);
   	 	SelectTextDraw(playerid, -1);
        return 1;
    }
    return 0;
}

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid)
{
    if(GetPlayerWeapon(playerid) == 34)
    {
    	if(IsUsingSuperSniper[playerid] == 1)
    	{
        	new Float:x, Float:y, Float:z;
        	print("bomm bomm");
			GetPlayerPos(damagedid, x, y, z);
	 		CreateExplosion(x, y, z, 12, 10.0);
 	 		CreateExplosion(x, y, z, 12, 10.0);
 	  		CreateExplosion(x, y, z, 12, 10.0);
 	  		SetPlayerHealth(damagedid, 0);
		}
	}
    return 1;
}

public OnPlayerUpdate(playerid)
{
    if(GetPlayerWeapon(playerid) == 34)
    {
            if(IsUsingSuperSniper[playerid] != 1) return 0;
            new ammo = GetPlayerAmmo(playerid);
			if(ammo <= 1)
 	  		{
 	  	    	IsUsingSuperSniper[playerid] = 0;
 	  	    	return 1;
			}
	}
    return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(clickedid == ss14)
    {
        UnShowPlayerSuperSniperMenu(playerid);
        CancelSelectTextDraw(playerid);
    }
    else if(clickedid == ss11)
    {
        BuySuperSniper(playerid);
    }
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
   	IsUsingSuperSniper[playerid] = 0;
    return 1;
}

public OnPlayerConnect(playerid)
{
    IsUsingSuperSniper[playerid] = 0;
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    IsUsingSuperSniper[playerid] = 0;
    return 1;
}

stock ShowPlayerSuperSniperMenu(playerid)
{
    TextDrawShowForPlayer(playerid,ss0);
	TextDrawShowForPlayer(playerid,ss1);
	TextDrawShowForPlayer(playerid,ss2);
	TextDrawShowForPlayer(playerid,ss3);
	TextDrawShowForPlayer(playerid,ss4);
	TextDrawShowForPlayer(playerid,ss5);
	TextDrawShowForPlayer(playerid,ss6);
	TextDrawShowForPlayer(playerid,ss7);
	TextDrawShowForPlayer(playerid,ss8);
	TextDrawShowForPlayer(playerid,ss9);
	TextDrawShowForPlayer(playerid,ss10);
	TextDrawShowForPlayer(playerid,ss11);
	TextDrawShowForPlayer(playerid,ss12);
	TextDrawShowForPlayer(playerid,ss13);
	TextDrawShowForPlayer(playerid,ss14);
}

stock UnShowPlayerSuperSniperMenu(playerid)
{
    TextDrawHideForPlayer(playerid,ss0);
	TextDrawHideForPlayer(playerid,ss1);
	TextDrawHideForPlayer(playerid,ss2);
	TextDrawHideForPlayer(playerid,ss3);
	TextDrawHideForPlayer(playerid,ss4);
	TextDrawHideForPlayer(playerid,ss5);
	TextDrawHideForPlayer(playerid,ss6);
	TextDrawHideForPlayer(playerid,ss7);
	TextDrawHideForPlayer(playerid,ss8);
	TextDrawHideForPlayer(playerid,ss9);
	TextDrawHideForPlayer(playerid,ss10);
	TextDrawHideForPlayer(playerid,ss11);
	TextDrawHideForPlayer(playerid,ss12);
	TextDrawHideForPlayer(playerid,ss13);
	TextDrawHideForPlayer(playerid,ss14);

}

stock BuySuperSniper(playerid)
{
    if(GetPlayerMoney(playerid) < 5000) return SendClientMessage(playerid,-1,"{9F9A9A} you need more {FE0E0E}than 5000$ {9F9A9A}to able to buy this weapon");
    GivePlayerMoney(playerid, -5000);
    GivePlayerWeapon (playerid,34,31);
    GameTextForPlayer(playerid, "~r~-5000", 3000, 1);
    IsUsingSuperSniper[playerid] = 1;
    return 1;
}
