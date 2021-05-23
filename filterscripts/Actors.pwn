// **** IMPORTANTE PARA PODER CREAR EJECTUR EL COMANDO TIENES QUE INICIAR SESIÓN CON RCON *****
// **** FILTERSCRIPT CREADO POR GUSTAVO PORKASLOV ****
// *** SIGUEME EN YOUTUBE, DALE ME GUSTA A MIS VIDEOS ME AYUDARIAS UN MONTON ********

#include <a_samp>
#include <zcmd>
#include <dini>
#include <sscanf2>

#define FilterScript
#define             COLOR_PORKA                 0x0091FFFF
#define             MAX_ACTOR                   100

enum AInfo
{
	ActorSkin,
	Float:ActorPosX,
	Float:ActorPosY,
	Float:ActorPosZ,
	Float:ActorPosRX,
	ActorVW,
	ActorI,
	Text3D:Text3D

};
new ActorInfo[MAX_ACTOR][AInfo];
public OnFilterScriptInit()
{
	CargarActores();
	print("\n--------------------------------------");
	print("FileScript Actores Dinámicos Creado por Porkaslov");
	print("Tús actores han cargado correctamente . . . .");
	print("--------------------------------------\n");
	return 1;
}
CMD:crearactor(playerid, params[])
{
if(IsPlayerAdmin(playerid)) {
new skin, Float:pos[4], vw, id, texto[124];
if(sscanf(params, "dd",id, skin)) return SendClientMessage(playerid, COLOR_PORKA, "Información: uso correcto /crearactor (id) (skin)");
if(id < 0 || id > MAX_ACTOR) return SendClientMessage(playerid, COLOR_PORKA, "Información: el id no puede ser menor de 1 ni mayor a 100");
if(ActorInfo[id][ActorSkin] > 0) return SendClientMessage(playerid, COLOR_PORKA, "Información: este actor ya fue creado, intenta con otra ID");
GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
vw = GetPlayerVirtualWorld(playerid);
SetPlayerPos(playerid, pos[0]+1, pos[1]+1, pos[2]+1);
GetPlayerFacingAngle(playerid, pos[3]);
// Creación del actor.
format(texto, sizeof(texto), "[ACTOR ID: %d]\n", id);
ActorInfo[id][ActorPosX] = pos[0];
ActorInfo[id][ActorPosY] = pos[1];
ActorInfo[id][ActorPosZ] = pos[2];
ActorInfo[id][ActorVW] = vw;
ActorInfo[id][ActorPosRX] = pos[3];
ActorInfo[id][ActorSkin] = skin;
ActorInfo[id][Text3D] = Create3DTextLabel(texto,COLOR_PORKA,ActorInfo[id][ActorPosX],ActorInfo[id][ActorPosY],ActorInfo[id][ActorPosZ], 10.0, ActorInfo[id][ActorVW]);
ActorInfo[id][ActorI] = CreateActor(skin, pos[0], pos[1], pos[2], pos[3]);
saveActor();
SendClientMessage(playerid, COLOR_PORKA, "Información: has creado correctamente un NPC en las coordenadas");
} else SendClientMessage(playerid, COLOR_PORKA, "Información: no eres administrador");
return 1;
}
CMD:borraractor(playerid, params[])
{
if(IsPlayerAdmin(playerid)) {
new id;
if(sscanf(params, "d", id)) return SendClientMessage(playerid, COLOR_PORKA, "Información: uso correcto /borraractor (id)");
DestroyActor(ActorInfo[id][ActorI]);
if(ActorInfo[id][ActorSkin] == 0) return SendClientMessage(playerid, COLOR_PORKA, "Información: no puedes borrar un actor que no se ha creado");
SendClientMessage(playerid, COLOR_PORKA, "Información: has borrado correctamente el actor de tus coordenadas");
ActorInfo[id][ActorPosX] = 0;
ActorInfo[id][ActorPosY] = 0;
ActorInfo[id][ActorPosZ] = 0;
ActorInfo[id][ActorPosRX] = 0;
ActorInfo[id][ActorVW] = 0;
ActorInfo[id][ActorSkin] = 0;
Delete3DTextLabel(ActorInfo[id][Text3D]);
saveActor();
} else SendClientMessage(playerid, COLOR_PORKA, "Información: no eres administrador");
return 1;
}
public OnFilterScriptExit()
{
saveActor();
return 1;
}
saveActor()
{
	new szFileStr[512],File: fHandle = fopen("actores.cfg", io_write);
	for(new a; a < MAX_ACTOR; a++)
	{
	    format(szFileStr, sizeof(szFileStr), "%d|%f|%f|%f|%f|%d\n",
	    ActorInfo[a][ActorSkin],
     	ActorInfo[a][ActorPosX],
	    ActorInfo[a][ActorPosY],
	    ActorInfo[a][ActorPosZ],
	    ActorInfo[a][ActorPosRX],
	    ActorInfo[a][ActorVW]);
    	fwrite(fHandle, szFileStr);
	}
	return fclose(fHandle);
}
CargarActores()
{
if(!fexist("actores.cfg")) return 1;
new szFileStr[512],iIndex,File: iFileHandle = fopen("actores.cfg", io_read);
while(iIndex < sizeof(ActorInfo) && fread(iFileHandle, szFileStr)) {
sscanf(szFileStr, "p<|>dffffd",
ActorInfo[iIndex][ActorSkin],
ActorInfo[iIndex][ActorPosX],
ActorInfo[iIndex][ActorPosY],
ActorInfo[iIndex][ActorPosZ],
ActorInfo[iIndex][ActorPosRX],
ActorInfo[iIndex][ActorVW]
);
if(ActorInfo[iIndex][ActorSkin] > 0) {
new texto[124];
ActorInfo[iIndex][ActorI] = CreateActor(ActorInfo[iIndex][ActorSkin],ActorInfo[iIndex][ActorPosX],ActorInfo[iIndex][ActorPosY],ActorInfo[iIndex][ActorPosZ], ActorInfo[iIndex][ActorPosRX]);
format(texto, sizeof(texto), "[ACTOR ID: %d]\n%s", iIndex);
ActorInfo[iIndex][Text3D] = Create3DTextLabel(texto,COLOR_PORKA,ActorInfo[iIndex][ActorPosX],ActorInfo[iIndex][ActorPosY],ActorInfo[iIndex][ActorPosZ], 10.0, ActorInfo[iIndex][ActorVW]);
}
++iIndex;
}
print("[script] Actores Cargados correctamente . . .");
return fclose(iFileHandle);
}

