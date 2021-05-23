//includes
#include <a_samp>
//defines
#define DIALOG 			1600
#define MAX_VEHICLE_OBJECTS     (50)
#define TIMER_INTERVAL          (400)
#define STREAM_OBJECT_OUT(%0)                                										\
	DestroyObject(objects[(%0)][object_objectid]);          										\
	objects[(%0)][object_objectid] = 0
//enums
enum SavePosENUM { Float:sX, Float:sY, Float:sZ, Float:sA, SavedPos };
enum object_data
{
    object_modelid,
	object_objectid,
	object_vehicleid,
 	Float:object_distance,
	Float:object_x,
	Float:object_y,
	Float:object_z,
	Float:object_rx,
	Float:object_ry,
	Float:object_rz,
}
//news
new Float:objects[MAX_VEHICLE_OBJECTS][object_data];
new engine,lights,alarm,doors,bonnet,boot,objective;
//forwards
forward StreamVehicleObjects();
forward DestroyVehicleObject(vobjectid);
forward RemoveObjectsFromVehicle(vehicleid);
forward CreateVehicleObject(modelid, vehicleid,
							Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ,
							Float:fRotX, Float:fRotY, Float:fRotZ, Float:stream_distance);
//////////////////////////////////////////////////////////////////////////////////////////////////////////
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" ScRaT FilterScript Attach Objects To Vehicle");
	print("--------------------------------------\n");
	SetTimer("StreamVehicleObjects", TIMER_INTERVAL, true);
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

///////////////////publics to stream objects////////////////////////////
public StreamVehicleObjects()
{
    new Float:x, Float:y, Float:z,
		world, vehicleid;
	for (new id=1; id < MAX_VEHICLE_OBJECTS; id++) if (objects[id][object_modelid])
	{
		if (!GetVehiclePos((vehicleid = objects[id][object_vehicleid]), x, y ,z)) //vehicle not spawned
		{
		    if (objects[id][object_objectid])
			{
				STREAM_OBJECT_OUT(id);
			}
		    continue;
		}

		world = GetVehicleVirtualWorld(vehicleid);

		new in_range;
		for (new playerid; playerid < MAX_PLAYERS; playerid++) if (IsPlayerInRangeOfPoint(playerid, objects[id][object_distance], x, y, z) && GetPlayerVirtualWorld(playerid) == world)
		{
	        in_range = 1;
	        break;
		}

		if (in_range == 1 && objects[id][object_objectid] == 0) //streaming in
		{
			new objectid = CreateObject(objects[id][object_modelid], 0, 0, 0, 0, 0, 0, 300.0);
			if (objectid != INVALID_OBJECT_ID)
			{
			    objects[id][object_objectid] = objectid;
			    AttachObjectToVehicle(objectid, objects[id][object_vehicleid],
							objects[id][object_x], objects[id][object_y], objects[id][object_z],
							objects[id][object_rx], objects[id][object_ry], objects[id][object_rz]);
			}
		}
		else if (in_range == 0 && objects[id][object_objectid] !=  0) //streaming out
		{
		    STREAM_OBJECT_OUT(id);
		}
	}
}

public RemoveObjectsFromVehicle(vehicleid)
{
	new n;
	for (new i=1; i < MAX_VEHICLE_OBJECTS; i++) if (objects[i][object_vehicleid] == vehicleid)
	{
	    DestroyVehicleObject(i);
	    n++;
	}
	return n;
}

public DestroyVehicleObject(vobjectid)
{
	if (vobjectid == 0 || objects[vobjectid][object_modelid] == 0) return 0;
	STREAM_OBJECT_OUT(vobjectid);
	objects[vobjectid][object_modelid] 		= 0;
	objects[vobjectid][object_vehicleid] 	= 0;
	return 1;
}

public CreateVehicleObject(modelid, vehicleid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:stream_distance)
{
	if (vehicleid == 0 || vehicleid == INVALID_VEHICLE_ID || modelid ==0) return 0;
	new id;
	for (new i=1; i < MAX_VEHICLE_OBJECTS; i++) if (objects[i][object_modelid] == 0)
	{
	    id = i;
	    break;
	}
	if (id == 0) return 0;

	objects[id][object_x]    		= fOffsetX;
	objects[id][object_y]    		= fOffsetY;
	objects[id][object_z]    		= fOffsetZ;

	objects[id][object_rx]    		= fRotX;
	objects[id][object_ry]    		= fRotY;
	objects[id][object_rz]    		= fRotZ;

	objects[id][object_distance]    = stream_distance;
	objects[id][object_vehicleid] 	= vehicleid;
	objects[id][object_objectid] 	= 0;
	objects[id][object_modelid] 	= modelid;
	return id;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp(cmdtext, "/vhold", true))
    {
    	ShowPlayerDialog(playerid, DIALOG+1, DIALOG_STYLE_LIST, "*Attach Objects*", "{ffff12}Death Race Euros\
																				\n{ff0303}Elegy Big Subwoofer\
		 																		\n{ffff12}Elegy Medium Subwoofer\
			 																	\n{ff0303}Elegy Normal Subwoofer\
																				\n{ffff12}Cannon Infernus\
																				\n{ff0303}Burning Uranus\
																				\n{ffff12}Minigun Patriot\
																				\n{ff0303}Cookie Vortex\
																				\n{ffff12}GhostRider FreeWay\
																				\n{ff0303}Spoiler Elegy\
																				\n{ffff12}Neon\
																				\n{ffff12}Turbo Elegy\
																				\n{ff0303}Delete All\
																				", "Add", "Cancel");
		return 1;
    }
    return 0;
}


public OnPlayerExitVehicle(playerid, vehicleid)
{
    RemoveObjectsFromVehicle(vehicleid);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    RemoveObjectsFromVehicle(GetPlayerVehicleID(playerid));
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
    RemoveObjectsFromVehicle(vehicleid);
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
    RemoveObjectsFromVehicle(vehicleid);
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
    RemoveObjectsFromVehicle(vehicleid);
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
    RemoveObjectsFromVehicle(GetPlayerVehicleID(playerid));
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
	if(dialogid == DIALOG+1)
	{
		if(response)
		{
			if(listitem == 0) //DEATH RACE EUROS
			{
			    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 587)
			    {
 					RemoveObjectsFromVehicle(vehicleid);
			        CreateVehicleObject(1023,GetPlayerVehicleID(playerid),0.000000, -2.515010, 0.264999, 0.000000, 0.000000, 0.000000,50);
					CreateVehicleObject(1005,GetPlayerVehicleID(playerid),0.004999, 1.349998, 0.274999, 0.000000, 0.000000, 0.000000,50);
					CreateVehicleObject(1034,GetPlayerVehicleID(playerid),-0.244999, -0.369999, -0.054999, 0.000000, 0.000000, 0.000000,50);
					CreateVehicleObject(1034,GetPlayerVehicleID(playerid),0.229999, -0.369999, -0.054999, 0.000000, 0.000000, 0.000000,50);
					CreateVehicleObject(1116,GetPlayerVehicleID(playerid),-0.015000, 2.500009, -0.489999, 32.159988, -0.000000, 0.000000,50);
					CreateVehicleObject(1160,GetPlayerVehicleID(playerid),-1.089999, 1.399999, -0.274999, 0.000000, -0.000000, 0.000000,50);
					CreateVehicleObject(1114,GetPlayerVehicleID(playerid),-0.469999, 1.694998, -0.199999, -160.800003, -0.000001, 0.000000,50);
					CreateVehicleObject(1114,GetPlayerVehicleID(playerid),0.509999, 1.694998, -0.199999, -160.800003, -0.000001, 0.000000,50);
					CreateVehicleObject(1013,GetPlayerVehicleID(playerid),0.004999, 2.265004, -0.199999, -3.015001, -0.000001, 0.000000,50);
					CreateVehicleObject(1010,GetPlayerVehicleID(playerid),0.599999, 1.399999, 0.189999, -3.015001, -0.000001, 0.000000,50);
					CreateVehicleObject(1010,GetPlayerVehicleID(playerid),-0.644999, 1.399999, 0.189999, -2.010001, -0.000001, 180.900100,50);
					CreateVehicleObject(3056,GetPlayerVehicleID(playerid),-0.000000, -1.264998, 0.574999, -0.000001, 68.340011, 449.236389,50);
					ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Death Race Euros","{f7ff00}You Added {50ff05}Death Race Kit To {f7ff00}Euros!","OK","");
				}
				else
			    {
			        ShowPlayerDialog(playerid, 6543+3,DIALOG_STYLE_MSGBOX,"{05F01C}Error!!!","{33FF00}Only In Euros !!!","OK","");
				}
			}
			if(listitem == 1) //SBE
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 562)
    			{
 					RemoveObjectsFromVehicle(vehicleid);
			        GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,1,objective);
					CreateVehicleObject(2232,GetPlayerVehicleID(playerid),0.025002, -1.729998, -0.020000, -74.369995, 87.133476, -3.015000,50);
					ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Big Elegy Subwoofer","{f7ff00}You Added {50ff05}Big Subwoofer Kit To {f7ff00}Elegy!","OK","");
				}
				else
    			{
					ShowPlayerDialog(playerid, 6543+3,DIALOG_STYLE_MSGBOX,"{05F01C}Error!!!","{33FF00}Only In Elegy !!!","OK","");
				}
			}
			if(listitem == 2) //SME
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 562)
    			{
 					RemoveObjectsFromVehicle(vehicleid);
			        GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,1,objective);
					CreateVehicleObject(2231,GetPlayerVehicleID(playerid),-0.039997, -2.190002, -0.229999, -85.424964, 84.419967, -6.030000,50);
					CreateVehicleObject(2231,GetPlayerVehicleID(playerid), -0.829996, -2.190002, -0.229999, -85.424964, 84.419967, -6.030000,50);
					ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Medium Elegy Subwoofer","{f7ff00}You Added {50ff05}Medium Subwoofer Kit To {f7ff00}Elegy!","OK","");
				}
				else
    			{
					ShowPlayerDialog(playerid, 6543+3,DIALOG_STYLE_MSGBOX,"{05F01C}Error!!!","{33FF00}Only In Elegy !!!","OK","");
				}
			}
			if(listitem == 3) //SNE
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 562)
    			{
 					RemoveObjectsFromVehicle(vehicleid);
			        GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,1,objective);
					CreateVehicleObject(2230,GetPlayerVehicleID(playerid), -0.664996, -2.190002, -0.229999, -85.424964, 84.419967, -6.030000,50);
					ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Normal Elegy Subwoofer","{f7ff00}You Added {50ff05}Normal Subwoofer Kit To {f7ff00}Elegy!","OK","");
				}
				else
    			{
					ShowPlayerDialog(playerid, 6543+3,DIALOG_STYLE_MSGBOX,"{05F01C}Error!!!","{33FF00}Only In Elegy !!!","OK","");
				}
			}
			if(listitem == 4) //ci
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 411)
    			{
 					RemoveObjectsFromVehicle(vehicleid);
			        CreateVehicleObject(1023,GetPlayerVehicleID(playerid), 0.000000, -2.372508, 0.120000, 0.000000, 0.000000, 0.000000,50);
					CreateVehicleObject(3267,GetPlayerVehicleID(playerid), 0.000000, -0.127501, 0.105000, 0.000000, 0.000000, 0.000000,50);
					ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Cannon Infernus","{f7ff00}You Added {50ff05}Cannon And Spoiler Kit To {f7ff00}Infernus!","OK","");
				}
				else
    			{
					ShowPlayerDialog(playerid, 6543+3,DIALOG_STYLE_MSGBOX,"{05F01C}Error!!!","{33FF00}Only In Infernus !!!","OK","");
				}
			}
			if(listitem == 5) //bu
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
    			{
 					RemoveObjectsFromVehicle(vehicleid);
			        CreateVehicleObject(18688,GetPlayerVehicleID(playerid), 0.954999, -1.574998, -1.974998, 0.000000, 0.000000, 0.000000,50);
					CreateVehicleObject(18688,GetPlayerVehicleID(playerid), -1.254998, -1.574998, -1.974998, 0.000000, 0.000000, 0.000000,50);
					ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Burning Uranus","{f7ff00}You Added {50ff05}Burning Uranus Kit To {f7ff00}Uranus!","OK","");
				}
				else
    			{
					ShowPlayerDialog(playerid, 6543+3,DIALOG_STYLE_MSGBOX,"{05F01C}Error!!!","{33FF00}Only In Uranus !!!","OK","");
				}
			}
			if(listitem == 6) //mp
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 470)
    			{
 					RemoveObjectsFromVehicle(vehicleid);
			        CreateVehicleObject(2985,GetPlayerVehicleID(playerid),  0.000000, -1.274999, 1.014999, -0.000000, -0.000000, 89.444953,50);
					CreateVehicleObject(2985,GetPlayerVehicleID(playerid), 1.064999, 0.773501, 0.155000, 90.449951, -0.000000, 89.444953,50);
					CreateVehicleObject(2985,GetPlayerVehicleID(playerid), -1.049999, 0.868501, 0.155000, 269.445526, 180.900100, 270.345520,50);
					ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Minigun Patriot","{f7ff00}You Added {50ff05}Miniguns Kit To {f7ff00}Patriot!","OK","");
				}
				else
    			{
					ShowPlayerDialog(playerid, 6543+3,DIALOG_STYLE_MSGBOX,"{05F01C}Error!!!","{33FF00}Only In Patriot !!!","OK","");
				}
			}
			if(listitem == 7) //grf
			{
				if(GetVehicleModel(vehicleid) == 539)
    			{
 					RemoveObjectsFromVehicle(vehicleid);
			        CreateVehicleObject(18782,GetPlayerVehicleID(playerid), -0.434999, 0.000000, 0.584999, 0.000000, 0.000000, 0.000000,50);
					ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Cookie Vortex","{f7ff00}You Added {50ff05}Cookie Kit To {f7ff00}Vortex!","OK","");
				}
				else
    			{
					ShowPlayerDialog(playerid, 6543+3,DIALOG_STYLE_MSGBOX,"{05F01C}Error!!!","{33FF00}Only In Vortex !!!","OK","");
				}
			}
			if(listitem == 8) //cv
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 463)
    			{
 					RemoveObjectsFromVehicle(vehicleid);
			        CreateVehicleObject(18668,GetPlayerVehicleID(playerid), 0.000000, 0.769999, -1.984998, 0.000000, 0.000000, 0.000000,50);
					CreateVehicleObject(18668,GetPlayerVehicleID(playerid), 0.000000, -1.189998, -1.984998, 0.000000, 0.000000, 0.000000,50);
					ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Ghost Rider Freeway","{f7ff00}You Added {50ff05}Ghost Rider Kit To {f7ff00}Freeway!","OK","");
				}
				else
    			{
					ShowPlayerDialog(playerid, 6543+3,DIALOG_STYLE_MSGBOX,"{05F01C}Error!!!","{33FF00}Only In Freeway !!!","OK","");
				}
			}
			if(listitem == 9) //super elegy
			{
				if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 562)
    			{
 					RemoveObjectsFromVehicle(vehicleid);
			        CreateVehicleObject(1023, GetPlayerVehicleID(playerid), 0.000000, -2.205003, 0.309999, 0.000000, 0.000000, 0.000000,50); //Object Model: 1023 |
					CreateVehicleObject(1023, GetPlayerVehicleID(playerid), 0.000000, -2.265004, 0.499999, 0.000000, 0.000000, 0.000000,50); //Object Model: 1023 |
					CreateVehicleObject(1023, GetPlayerVehicleID(playerid), 0.000000, -2.335005, 0.704999, 0.000000, 0.000000, 0.000000,50); //Object Model: 1023 |
					CreateVehicleObject(1023, GetPlayerVehicleID(playerid), 0.000000, -2.390007, 0.899999, 0.000000, 0.000000, 0.000000,50); //Object Model: 1023 |
					CreateVehicleObject(1023, GetPlayerVehicleID(playerid), 0.000000, -2.455008, 1.094999, 0.000000, 0.000000, 0.000000,50); //Object Model: 1023 |
					CreateVehicleObject(1023, GetPlayerVehicleID(playerid), 0.000000, -2.530010, 1.299998, 0.000000, 0.000000, 0.000000,50); //Object Model: 1023 |
					CreateVehicleObject(1023, GetPlayerVehicleID(playerid), 0.000000, -2.595011, 1.489998, 0.000000, 0.000000, 0.000000,50); //Object Model: 1023 |
					CreateVehicleObject(1023, GetPlayerVehicleID(playerid), 0.000000, -2.665013, 1.674998, 0.000000, 0.000000, 0.000000,50); //Object Model: 1023 |
					ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Spoiler Elegy","{f7ff00}You Added {50ff05}Spoilers Kit To {f7ff00}Elegy!","OK","");
				}
				else
    			{
					ShowPlayerDialog(playerid, 6543+3,DIALOG_STYLE_MSGBOX,"{05F01C}Error!!!","{33FF00}Only In Elegy !!!","OK","");
				}
			}
			if(listitem == 10) //neon system
			{
				ShowPlayerDialog(playerid, DIALOG+3,DIALOG_STYLE_LIST,"{05F01C}Neon System","{1008ff}Blue\
																							\n{ff1212}Red\
																							\n{29ff08}Green\
																							\n{ffffff}White\
																							\n{ff70ec}Pink\
																							\n{fff81f}Yellow\
																							\n{7d93ff}Police Neon\
																							\n{82c5ff}Interior Neon\
																							\n{a98fff}Back Neon\
																							\n{8f8fff}Front Neon\
																							\n{a8c5ff}Undercover Neon\
																							","OK","");
			}
			if(listitem == 11) //turbo elegy
			{
			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 562)
    			{
 					RemoveObjectsFromVehicle(vehicleid);
			        CreateVehicleObject(1034, GetPlayerVehicleID(playerid), 0.000000, -0.069999, 0.179999, 0.000000, 0.000000, 0.000000,50); //Object Model: 1034 |
					CreateVehicleObject(1034, GetPlayerVehicleID(playerid), 0.009999, -0.115000, 0.349999, 0.000000, 0.000000, 0.000000,50);//Object Model: 1034 |
					CreateVehicleObject(1034, GetPlayerVehicleID(playerid), -0.199999, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000,50); //Object Model: 1034 |
					CreateVehicleObject(1034, GetPlayerVehicleID(playerid), 0.209999, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000,50); //Object Model: 1034 |
					CreateVehicleObject(1034, GetPlayerVehicleID(playerid), 0.199999, -0.064999, 0.169999, 0.000000, 0.000000, 0.000000,50); //Object Model: 1034 |
					CreateVehicleObject(1034, GetPlayerVehicleID(playerid), -0.199999, -0.069999, 0.169999, 0.000000, 0.000000, 0.000000,50);//Object Model: 1034 |
					CreateVehicleObject(1034, GetPlayerVehicleID(playerid), -0.204999, -0.125000, 0.344999, 0.000000, 0.000000, 0.000000,50); //Object Model: 1034 |
					CreateVehicleObject(1034, GetPlayerVehicleID(playerid), 0.194999, -0.125000, 0.354999, 0.000000, 0.000000, 0.000000,50); //Object Model: 1034 |
					CreateVehicleObject(1034,GetPlayerVehicleID(playerid),0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000,50); //Object Model: 1034 |
					ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Turbo Elegy","{f7ff00}You Added {50ff05}Turbo Kit To {f7ff00}Elegy!","OK","");
				}
				else
    			{
					ShowPlayerDialog(playerid, 6543+3,DIALOG_STYLE_MSGBOX,"{05F01C}Error!!!","{33FF00}Only In Elegy !!!.","OK","");
				}
			}
			if(listitem == 12) //delete
			{
	 			RemoveObjectsFromVehicle(vehicleid);
			}
		}
	}
	if(dialogid == DIALOG+3)
	{
		if(response)
		{
			if(listitem == 0)
			{
				SetPlayerTime(playerid,0,0);
				RemoveObjectsFromVehicle(vehicleid);
    			CreateVehicleObject(18648, GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0,50);
				CreateVehicleObject(18648, GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0,50);
				ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Blue Neon","{f7ff00}You Added {50ff05}Blue Neon To {f7ff00}Your Vehicle!","OK","");
			}
			if(listitem == 1)
			{
				SetPlayerTime(playerid,0,0);
				RemoveObjectsFromVehicle(vehicleid);
    			CreateVehicleObject(18647, GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0,50);
				CreateVehicleObject(18647, GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0,50);
				ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Blue Neon","{f7ff00}You Added {50ff05}Red Neon To {f7ff00}Your Vehicle!","OK","");
			}
			if(listitem == 2)
			{
				SetPlayerTime(playerid,0,0);
				RemoveObjectsFromVehicle(vehicleid);
    			CreateVehicleObject(18649, GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0,50);
				CreateVehicleObject(18649, GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0,50);
				ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Blue Neon","{f7ff00}You Added {50ff05}Green Neon To {f7ff00}Your Vehicle!","OK","");
			}
			if(listitem == 3)
			{
				SetPlayerTime(playerid,0,0);
				RemoveObjectsFromVehicle(vehicleid);
    			CreateVehicleObject(18652, GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0,50);
				CreateVehicleObject(18652, GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0,50);
				ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Blue Neon","{f7ff00}You Added {50ff05}White Neon To {f7ff00}Your Vehicle!","OK","");
			}
			if(listitem == 4)
			{
				SetPlayerTime(playerid,0,0);
				RemoveObjectsFromVehicle(vehicleid);
    			CreateVehicleObject(18651, GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0,50);
				CreateVehicleObject(18651, GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0,50);
				ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Blue Neon","{f7ff00}You Added {50ff05}Pink Neon To {f7ff00}Your Vehicle!","OK","");
			}
			if(listitem == 5)
			{
				SetPlayerTime(playerid,0,0);
				RemoveObjectsFromVehicle(vehicleid);
    			CreateVehicleObject(18650, GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0,50);
				CreateVehicleObject(18650, GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0,50);
				ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Blue Neon","{f7ff00}You Added {50ff05}Yellow Neon To {f7ff00}Your Vehicle!","OK","");
			}
			if(listitem == 6)
			{
				SetPlayerTime(playerid,0,0);
				RemoveObjectsFromVehicle(vehicleid);
    			CreateVehicleObject(18646, GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0,50);
				CreateVehicleObject(18646, GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0,50);
				ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Blue Neon","{f7ff00}You Added {50ff05}Police Neon To {f7ff00}Your Vehicle!","OK","");
			}
            if(listitem == 7)
			{
				SetPlayerTime(playerid,0,0);
				RemoveObjectsFromVehicle(vehicleid);
    			CreateVehicleObject(18646, GetPlayerVehicleID(playerid), 0, -0.0, 0, 2.0, 2.0, 3.0,50);
				CreateVehicleObject(18646, GetPlayerVehicleID(playerid), 0, -0.0, 0, 2.0, 2.0, 3.0,50);
				ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Blue Neon","{f7ff00}You Added {50ff05}Interior Neon To {f7ff00}Your Vehicle!","OK","");
			}
          	if(listitem == 8)
			{
				SetPlayerTime(playerid,0,0);
				RemoveObjectsFromVehicle(vehicleid);
    			CreateVehicleObject(18646, GetPlayerVehicleID(playerid), -0.0, -1.5, -1, 2.0, 2.0, 3.0,50);
				CreateVehicleObject(18646, GetPlayerVehicleID(playerid), -0.0, -1.5, -1, 2.0, 2.0, 3.0,50);
				ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Blue Neon","{f7ff00}You Added {50ff05}Back Neon To {f7ff00}Your Vehicle!","OK","");
			}
  	        if(listitem == 9)
			{
				SetPlayerTime(playerid,0,0);
				RemoveObjectsFromVehicle(vehicleid);
    			CreateVehicleObject(18646, GetPlayerVehicleID(playerid), -0.0, 1.5, -0.6, 2.0, 2.0, 3.0,50);
				CreateVehicleObject(18646, GetPlayerVehicleID(playerid), -0.0, 1.5, -0.6, 2.0, 2.0, 3.0,50);
				ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Blue Neon","{f7ff00}You Added {50ff05}Front Neon To {f7ff00}Your Vehicle!","OK","");
			}
            if(listitem == 10)
			{
				SetPlayerTime(playerid,0,0);
				RemoveObjectsFromVehicle(vehicleid);
    			CreateVehicleObject(18646, GetPlayerVehicleID(playerid), -0.5, -0.2, 0.8, 2.0, 2.0, 3.0,50);
				CreateVehicleObject(18646, GetPlayerVehicleID(playerid), -0.5, -0.2, 0.8, 2.0, 2.0, 3.0,50);
				ShowPlayerDialog(playerid, DIALOG+2,DIALOG_STYLE_MSGBOX,"{05F01C}Blue Neon","{f7ff00}You Added {50ff05}Undercover Neon To {f7ff00}Your Vehicle!","OK","");
			}
		}
	}
 	return 0;
}
