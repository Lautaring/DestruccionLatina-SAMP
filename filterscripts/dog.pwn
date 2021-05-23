//Vehicle Exported with Texture Studio By: [uL]Pottus/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include <a_samp>

new dog;

public OnFilterScriptInit()
{ 
    new tmpobjid;

    dog = CreateVehicle(441,2070.779,1349.994,10.671,126.292,0,0,-1);
	LinkVehicleToInterior(dog, 6);

    tmpobjid = CreateObject(1241,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", -13426159);
    AttachObjectToVehicle(tmpobjid, dog, 0.019, 0.500, 0.649, 0.000, -60.000, 90.000);
    tmpobjid = CreateObject(1241,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", -13426159);
    AttachObjectToVehicle(tmpobjid, dog, 0.000, 0.500, 0.649, 0.000, -60.000, 90.000);
    tmpobjid = CreateObject(1946,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", -13426159);
    AttachObjectToVehicle(tmpobjid, dog, 0.004, 0.360, 0.729, 0.000, 0.000, 0.000);
    tmpobjid = CreateObject(18644,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", -16777199);
    AttachObjectToVehicle(tmpobjid, dog, 0.070, 0.509, 0.810, 270.000, 0.000, 0.000);
    tmpobjid = CreateObject(18644,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", -16777199);
    AttachObjectToVehicle(tmpobjid, dog, -0.049, 0.509, 0.810, 270.000, 0.000, 0.000);
    tmpobjid = CreateObject(1974,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", -16777216);
    AttachObjectToVehicle(tmpobjid, dog, 0.000, 0.649, 0.689, 0.000, 0.000, 0.000);
    tmpobjid = CreateObject(1550,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, -1, "none", "none", 51);
    SetObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", -13426159);
    AttachObjectToVehicle(tmpobjid, dog, 0.019, 0.009, 0.490, 90.000, 0.000, 180.000);
    tmpobjid = CreateObject(1944,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", -13426159);
    AttachObjectToVehicle(tmpobjid, dog, 0.039, -0.360, 0.529, 0.000, 0.000, 0.000);
    tmpobjid = CreateObject(1944,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", -13426159);
    AttachObjectToVehicle(tmpobjid, dog, 0.029, -0.350, 0.460, 0.000, 0.000, 0.000);
    tmpobjid = CreateObject(1944,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", -13426159);
    AttachObjectToVehicle(tmpobjid, dog, -0.009, -0.350, 0.459, 1.000, 0.000, 0.000);
    tmpobjid = CreateObject(1944,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", -13426159);
    AttachObjectToVehicle(tmpobjid, dog, -0.019, -0.350, 0.520, 0.000, 0.000, 0.000);
    tmpobjid = CreateObject(19590,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", -10075051);
    AttachObjectToVehicle(tmpobjid, dog, 0.044, 0.069, 0.639, 360.000, 270.000, 185.000);
    tmpobjid = CreateObject(2905,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", -13426159);
    AttachObjectToVehicle(tmpobjid, dog, -0.109, 0.199, 0.319, 270.000, 0.000, -90.000);
    tmpobjid = CreateObject(2905,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", -13426159);
    AttachObjectToVehicle(tmpobjid, dog, -0.110, -0.229, 0.322, 270.000, 0.000, -90.000);
    tmpobjid = CreateObject(2905,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", -13426159);
    AttachObjectToVehicle(tmpobjid, dog, 0.109, -0.228, 0.305, 270.000, 0.000, -90.000);
    tmpobjid = CreateObject(2905,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", -13426159);
    AttachObjectToVehicle(tmpobjid, dog, 0.110, 0.209, 0.309, 270.000, 0.000, -90.000);
    tmpobjid = CreateObject(19578,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", -13426159);
    AttachObjectToVehicle(tmpobjid, dog, 0.009, -0.470, 0.769, 765.000, 270.000, 720.000);
    tmpobjid = CreateObject(19477,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterialText(tmpobjid, "O", 0, 130, "Ariel", 130, 0, -16764092, 0, 0);
    AttachObjectToVehicle(tmpobjid, dog, -1.150, 0.459, 0.279, 0.000, -35.000, 90.000);
    tmpobjid = CreateObject(1900,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", -17596);
    AttachObjectToVehicle(tmpobjid, dog, -0.009, 0.399, 0.353, 100.000, 0.000, 0.000);
    tmpobjid = CreateObject(19582,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", -13426159);
    AttachObjectToVehicle(tmpobjid, dog, -0.192, 0.370, 0.710, 271.000, 0.000, 85.000);
    tmpobjid = CreateObject(19582,0.0,0.0,-1000.0,0.0,0.0,0.0,300.0);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", -13426159);
    AttachObjectToVehicle(tmpobjid, dog, 0.205, 0.379, 0.709, 270.000, 91.000, 552.000);
    
}

public OnFilterScriptExit()
{ 
    DestroyVehicle(dog);
} 

public OnVehicleSpawn(vehicleid)
{
    if(vehicleid == dog)
    {
    }
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp(cmdtext, "/calldog", true))
    {
        SendClientMessage(playerid, -1, "Dog has come to you.");
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        SetVehiclePos(dog, x, y+1, z);
        return 1;
    }
    if(!strcmp(cmdtext, "/enterdog", true))
    {
		PutPlayerInVehicle(playerid, dog, 0);
		new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        return 1;
    }
    if(!strcmp(cmdtext, "/exitdog", true))
    {
		RemovePlayerFromVehicle(playerid);
		new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        SetPlayerPos(playerid, x+1, y+1, z+1);
        return 1;
    }
    return 1;
}
