#include <a_samp>


#define PROBANDO_FILE_LOAD "SATDM/Businesses/probando_setup.txt"
#define PROBANDO_FILE_SAVE "SATDM/Businesses/probando_save.txt"

#define DEFAULT_OWNER "[null]"
#define B_LIMIT 2800

enum bInfo
{
	name[MAX_PLAYER_NAME],
	owner[MAX_PLAYER_NAME],
	bought,
	cost,
	profit,
	cashbox,
 	Float:xpos,
	Float:ypos,
	Float:zpos,
	ico,
	inter,
}

new BizInfo[B_LIMIT][bInfo];
new bizcount;

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");

    //bizcount = CountBusinesses(PROBANDO_FILE_LOAD);
    SetupBusinesses();
	return 1;
}

stock CountBusinesses(filename[]) {
	new File:BusinessFile;
	new blank[128];
	new count = 0;
	if (fexist(PROBANDO_FILE_SAVE)) {
		BusinessFile = fopen(PROBANDO_FILE_SAVE);
		while(fread(BusinessFile, blank, sizeof blank)) {
			count++;
		}
		fclose(BusinessFile);
	}
	else {
		BusinessFile = fopen(filename);
		while(fread(BusinessFile, blank, sizeof blank)) {
			count++;
		}
		fclose(BusinessFile);
	}

	return count;
}


stock split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new slen;

	while(i <= strlen(strsrc)){
		if(strsrc[i]==delimiter || i==strlen(strsrc)){
			slen = strmid(strdest[aNum], strsrc, li, i, 128);
			strdest[aNum][slen] = 0;
			li = i+1;
			aNum++;
		}
		i++;
	}
	return 1;
}

stock SaveBusinesses()
{
	new filestring[128];
	new File: bfile = fopen(PROBANDO_FILE_SAVE, io_write);
	for(new bizid = 0;bizid<1;bizid++)
	{
		format(filestring, sizeof(filestring), "%f,%f,%f,%d,%s,%s,%d,%d,%d,%d\n",
		BizInfo[bizid][xpos],
		BizInfo[bizid][ypos],
		BizInfo[bizid][zpos],
		BizInfo[bizid][inter],
		BizInfo[bizid][owner],
		BizInfo[bizid][name],
		BizInfo[bizid][bought],
		BizInfo[bizid][cost],
		BizInfo[bizid][profit],
		BizInfo[bizid][cashbox]
		);
		fwrite(bfile, filestring);
        print("\n--------------------------------------");
	    print("        DATOS CARGADOS AL ARCHIVO       ");
	    print("--------------------------------------\n");
	}
	fclose(bfile);
}

stock SetupBusinesses()
{
    print("\n--------------------------------------");
	print("        SE EJECUTA?        ");
	print("--------------------------------------\n");
    new File: file;
    new SplitDiv[10][B_LIMIT];
    print("\n--------------------------------------");
	print("        DATOS CARGADOS AL VECTOR         ");
	print("--------------------------------------\n");
	new filestring[128];
	file = fopen(PROBANDO_FILE_LOAD, io_read);
	for(new bizid=0;bizid<2;bizid++)
	{
		if (file)
		{
			fread(file, filestring);
		 	split(filestring, SplitDiv, ',');
			BizInfo[bizid][xpos] = floatstr(SplitDiv[0]);
			BizInfo[bizid][ypos] = floatstr(SplitDiv[1]);
			BizInfo[bizid][zpos] = floatstr(SplitDiv[2]);
			BizInfo[bizid][inter] = strval(SplitDiv[3]);
			strmid(BizInfo[bizid][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
			strmid(BizInfo[bizid][name], SplitDiv[4], 0, strlen(SplitDiv[4]), 255);
			BizInfo[bizid][bought] = 0;
			BizInfo[bizid][cost] = strval(SplitDiv[5]);
			BizInfo[bizid][profit] = strval(SplitDiv[6]);
			BizInfo[bizid][cashbox] = 0;
            print("\n--------------------------------------");
	        print("        DATOS CARGADOS AL VECTOR         ");
	        print("--------------------------------------\n");
        }
	}
    fclose(file);
    SaveBusinesses();
}


public OnFilterScriptExit()
{
	return 1;
}



main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}


public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}