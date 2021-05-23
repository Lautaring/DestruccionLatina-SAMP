#include <a_samp>
#include <OnPlayerPause>

AntiDeAMX()
{
   new a[][] =
   {
      "Unarmed (Fist)",
      "Brass K"
   };
   #pragma unused a
}

#define red						0xFF0000AA
new ExplosionTimer;
new iscountactivated = 0;
new countamount;
new CountTimer;
new StopExplosion;
new Text:TBlastSurvival;
new Text:TTiempoRestante;
new Text:TJugadores;
new Text:TTiempoRestante2;
new Text:TJugadores2;
new objects[23];
new EmpezarBS;
new AbrirBS;
forward CargarBlastSurvival();
forward EmpezarBlastSurvival(playerid);
forward SpawnearPlayer();

enum BSEnums
{
	playerjoined,
	started,
	loaded,
	defaulttimer,
	usingcustomtimer,
	savedtime,
	timer,
	stopped,
	exploradius,
	explotype,
	playerlimit
}

new BlastSurvival[BSEnums];

enum pBS
{
	inblastsurvival,
	isspectating,
	inpos2
}

new pBlastSurvival[MAX_PLAYERS][pBS];

new Float:gRandomExplosion[28][3] = {
        {1778.4574,-1887.5756,13.3853},{1786.4574,-1887.5756,13.3853},{1794.4574,-1887.5756,13.3853},{1802.4574,-1887.5756,13.3853},
        {1778.4574,-1895.5756,13.3853},{1786.4574,-1895.5756,13.3853},{1794.4574,-1895.5756,13.3853},{1802.4574,-1895.5756,13.3853},
        {1778.4574,-1903.5756,13.3853},{1786.4574,-1903.5756,13.3853},{1794.4574,-1903.5756,13.3853},{1802.4574,-1903.5756,13.3853},
        {1778.4574,-1911.5756,13.3853},{1786.4574,-1911.5756,13.3853},{1794.4574,-1911.5756,13.3853},{1802.4574,-1911.5756,13.3853},
        {1778.4574,-1915.5756,13.3853},{1786.4574,-1915.5756,13.3853},{1794.4574,-1915.5756,13.3853},{1802.4574,-1915.5756,13.3853},
        {1778.4574,-1927.5756,13.3853},{1786.4574,-1927.5756,13.3853},{1794.4574,-1927.5756,13.3853},{1802.4574,-1927.5756,13.3853},
        {1778.4574,-1931.5756,13.3853},{1786.4574,-1931.5756,13.3853},{1794.4574,-1931.5756,13.3853},{1802.4574,-1931.5756,13.3853}
};

new Float:gRandomStartSpot[5][3] = {
		{1778.5582,-1887.4924,13.3883},{1791.3069,-1888.2378,13.3976},{1803.6039,-1888.9817,13.4066},{1803.6631,-1907.3964,13.3987},
		{1777.5652,-1904.3390,13.3875}
};

forward OnExplosionStarts(playerid);
forward CountDown();
forward OnStopExplosion(playerid);
forward Count();
forward CheckWinner();

public OnFilterScriptInit()
{
    AntiDeAMX();
	new a[][] =
    {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a

	objects[0] = CreateObject(12814, 1791.90027, -1910.55371, 12.44080,   0.00000, 0.00000, 0.00000);
	objects[1] = CreateObject(12814, 1761.91846, -1910.55383, 12.44080,   0.00000, 0.00000, 0.00000);
	objects[2] = CreateObject(12814, 1781.71680, -1896.61096, 12.41980,   0.00000, 0.00000, -91.00000);
	objects[3] = CreateObject(987, 1806.85376, -1923.62341, 12.43700,   0.00000, 0.00000, 269.98441);
	objects[4] = CreateObject(987, 1806.85376, -1911.69543, 12.43700,   0.00000, 0.00000, 269.98441);
	objects[5] = CreateObject(987, 1806.85376, -1887.83936, 12.43700,   0.00000, 0.00000, 269.98441);
	objects[6] = CreateObject(987, 1806.85376, -1884.43140, 12.43700,   0.00000, 0.00000, 269.98441);
	objects[7] = CreateObject(987, 1794.80811, -1884.43628, 12.43700,   0.00000, 0.00000, 359.98279);
	objects[8] = CreateObject(987, 1806.85376, -1899.76746, 12.43700,   0.00000, 0.00000, 269.98441);
	objects[9] = CreateObject(987, 1782.88013, -1884.43628, 12.43700,   0.00000, 0.00000, 359.98279);
	objects[10] = CreateObject(987, 1774.27014, -1884.43628, 12.43700,   0.00000, 0.00000, 359.98279);
	objects[11] = CreateObject(987, 1774.19226, -1896.45007, 12.43700,   0.00000, 0.00000, 90.06861);
	objects[12] = CreateObject(987, 1774.19226, -1908.45007, 12.43700,   0.00000, 0.00000, 90.06860);
	objects[13] = CreateObject(987, 1774.19226, -1920.45007, 12.43700,   0.00000, 0.00000, 90.06860);
	objects[14] = CreateObject(987, 1774.19226, -1932.45007, 12.43700,   0.00000, 0.00000, 90.06860);
	objects[15] = CreateObject(987, 1774.19226, -1935.65015, 12.43700,   0.00000, 0.00000, 90.06860);
	objects[16] = CreateObject(987, 1786.22217, -1935.71069, 12.43700,   0.00000, 0.00000, 179.89264);
	objects[17] = CreateObject(987, 1798.22217, -1935.71069, 12.43700,   0.00000, 0.00000, 179.89259);
	objects[18] = CreateObject(987, 1806.82214, -1935.71069, 12.43700,   0.00000, 0.00000, 179.89259);
	objects[19] = CreateObject(12814, 1791.77930, -1910.59473, 17.36540,   0.00000, 180.00000, 0.00000);
	objects[20] = CreateObject(12814, 1789.25928, -1910.59473, 17.37140,   0.00000, 180.00000, 0.00000);
	objects[21] = CreateObject(12814, 1791.77930, -1909.42468, 17.35940,   0.00000, 180.00000, 0.00000);
	objects[22] = CreateObject(12814, 1789.25928, -1909.47375, 17.36340,   0.00000, 180.00000, 0.00000);

	BlastSurvival[defaulttimer] = 150;
	BlastSurvival[exploradius] = 10;
	BlastSurvival[explotype] = 10;
	BlastSurvival[timer] = 2;
	BlastSurvival[playerlimit] = 20;

    TBlastSurvival = TextDrawCreate(2.000000, 430.000000, "Blast Survival");
    TextDrawBackgroundColor(TBlastSurvival, 255);
    TextDrawFont(TBlastSurvival, 0);
    TextDrawLetterSize(TBlastSurvival, 0.460000, 1.799999);
    TextDrawColor(TBlastSurvival, -16776961);
    TextDrawSetOutline(TBlastSurvival, 1);
    TextDrawSetProportional(TBlastSurvival, 1);
    
    TTiempoRestante = TextDrawCreate(224.000000, 430.000000, "Tiempo Restante:");
    TextDrawBackgroundColor(TTiempoRestante, 255);
    TextDrawFont(TTiempoRestante, 0);
    TextDrawLetterSize(TTiempoRestante, 0.460000, 1.799999);
    TextDrawColor(TTiempoRestante, 16711935);
    TextDrawSetOutline(TTiempoRestante, 1);
    TextDrawSetProportional(TTiempoRestante, 1);
    
    TJugadores = TextDrawCreate(482.000000, 430.000000, "Jugadores:");
    TextDrawBackgroundColor(TJugadores, 255);
    TextDrawFont(TJugadores, 0);
    TextDrawLetterSize(TJugadores, 0.460000, 1.799999);
    TextDrawColor(TJugadores, 16711935);
    TextDrawSetOutline(TJugadores, 1);
    TextDrawSetProportional(TJugadores, 1);

	TTiempoRestante2 = TextDrawCreate(327.000000, 432.000000, "150");
	TextDrawBackgroundColor(TTiempoRestante2, 255);
    TextDrawFont(TTiempoRestante2, 1);
    TextDrawLetterSize(TTiempoRestante2, 0.460000, 1.599998);
    TextDrawColor(TTiempoRestante2, -16711681);
    TextDrawSetOutline(TTiempoRestante2, 1);
    TextDrawSetProportional(TTiempoRestante2, 1);
    TextDrawSetShadow(TTiempoRestante2, 1);

	TJugadores2 = TextDrawCreate(547.000000, 432.000000, "99");
	TextDrawBackgroundColor(TJugadores2, 255);
    TextDrawFont(TJugadores2, 1);
    TextDrawLetterSize(TJugadores2, 0.460000, 1.599998);
    TextDrawColor(TJugadores2, -16711681);
    TextDrawSetOutline(TJugadores2, 1);
    TextDrawSetProportional(TJugadores2, 1);
    TextDrawSetShadow(TJugadores2, 1);
    AbrirBS = SetTimer("CargarBlastSurvival",60000,1);
	return 1;
}

public CargarBlastSurvival()
{
    KillTimer(AbrirBS);
    BlastSurvival[loaded] = 1;
    BlastSurvival[playerjoined] = 0;
    SendClientMessageToAll(red,"|Info| 認EAEAEA} En 30 segundos empezara el {919770}Blast Survival,{EAEAEA} usa {A9A9A9}/EntrarBlast{EAEAEA} para entrar.");
	EmpezarBS = SetTimer("EmpezarBlastSurvival",30000,1);
	return 1;
}

public EmpezarBlastSurvival(playerid)
{
    if(BlastSurvival[playerjoined] < 2)
    {
    if(pBlastSurvival[playerid][inblastsurvival] == 1)
    {
    TextDrawHideForPlayer(playerid, TBlastSurvival);
    TextDrawHideForPlayer(playerid, TTiempoRestante);
    TextDrawHideForPlayer(playerid, TJugadores);
    TextDrawHideForPlayer(playerid, TTiempoRestante2);
    TextDrawHideForPlayer(playerid, TJugadores2);
    SetPlayerVirtualWorld(playerid, 0);
    SpawnPlayer(playerid);
    pBlastSurvival[playerid][inblastsurvival] = 0;
    }
    if(pBlastSurvival[playerid][isspectating] == 1)
	{
	TextDrawHideForPlayer(playerid, TBlastSurvival);
    TextDrawHideForPlayer(playerid, TTiempoRestante);
    TextDrawHideForPlayer(playerid, TJugadores);
    TextDrawHideForPlayer(playerid, TTiempoRestante2);
    TextDrawHideForPlayer(playerid, TJugadores2);
    SetPlayerVirtualWorld(playerid, 0);
    SpawnPlayer(playerid);
    TogglePlayerControllable(playerid, 1);
    pBlastSurvival[playerid][isspectating] = 0;
	}
	AbrirBS = SetTimer("CargarBlastSurvival",1500000,1);
	SetTimer("SpawnearPlayer",3000,1);
	KillTimer(EmpezarBS);
    BlastSurvival[started] = 0;
    BlastSurvival[loaded] = 0;
    if(BlastSurvival[usingcustomtimer] == 1) {BlastSurvival[timer] = BlastSurvival[savedtime];}
    else {BlastSurvival[defaulttimer] = 150;}
    KillTimer(ExplosionTimer);
    BlastSurvival[playerjoined] = 0;
    KillTimer(StopExplosion);
    SendClientMessageToAll(red,"|Info| 認EAEAEA} El {919770}Blast Survival{EAEAEA} fue cancelado por falta de jugadores. Empezara otro en 25 minutos.");
	return 1;
    }
	CountTimer = SetTimer("Count",1000,true);
    BlastSurvival[loaded] = 1;
    BlastSurvival[started] = 1;
    countamount = 5;
    iscountactivated = 1;
    KillTimer(EmpezarBS);
    KillTimer(AbrirBS);
	return 1;
}

public OnPlayerPause(playerid)
{
    if(BlastSurvival[started] == 1)
    {
		if(pBlastSurvival[playerid][inblastsurvival] == 1)
	    {
		    new string[128], pName[MAX_PLAYER_NAME];
			GetPlayerName(playerid, pName, sizeof(pName));
			format(string,sizeof(string),"|Info| 認0080FF} %s {EAEAEA}fue expulsado del {919770}Blast Survival{EAEAEA} por estar en pausa.",pName);
			SendClientMessageToAll(red,string);
			BlastSurvival[playerjoined]--;
		    pBlastSurvival[playerid][inblastsurvival] = 0;
		    TextDrawHideForPlayer(playerid, TBlastSurvival);
	        TextDrawHideForPlayer(playerid, TTiempoRestante);
	        TextDrawHideForPlayer(playerid, TJugadores);
			TextDrawHideForPlayer(playerid, TTiempoRestante2);
			TextDrawHideForPlayer(playerid, TJugadores2);
			SetPlayerVirtualWorld(playerid, 0);
			SpawnPlayer(playerid);
			format(string,sizeof(string),"%d", BlastSurvival[playerjoined]);
			TextDrawSetString(TJugadores2, string);
			if(BlastSurvival[playerjoined] == 0)
			{
   				AbrirBS = SetTimer("CargarBlastSurvival",1500000,1);
				SetTimer("SpawnearPlayer",3000,1);
				KillTimer(EmpezarBS);
			    BlastSurvival[started] = 0;
			    BlastSurvival[loaded] = 0;
			    if(BlastSurvival[usingcustomtimer] == 1) {BlastSurvival[timer] = BlastSurvival[savedtime];}
			    else {BlastSurvival[defaulttimer] = 150;}
			    KillTimer(ExplosionTimer);
			    BlastSurvival[playerjoined] = 0;
			    KillTimer(StopExplosion);
			    SendClientMessageToAll(red,"|Info| 認EAEAEA} El {919770}Blast Survival{EAEAEA} fue cancelado por falta de jugadores. Empezara otro en 25 minutos.");
			}
	    }
    }
    return 1;
}

public OnPlayerUpdate(playerid)
{
    new Float:health;
	new Float:armour;
	GetPlayerHealth(playerid,health);
	GetPlayerArmour(playerid,armour);
 	new string[128], pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, sizeof(pName));
	if(BlastSurvival[started] == 1)
    {
		if(pBlastSurvival[playerid][inblastsurvival] == 1)
	    {
			if((health >= 100))
			{
				format(string, sizeof(string), "|Info| 認0080FF} %s {EAEAEA}fue expulsado del {919770}Blast Survival{EAEAEA} por recargar vida.",pName,playerid);
				SendClientMessageToAll(red, string);
				BlastSurvival[playerjoined]--;
		  		pBlastSurvival[playerid][inblastsurvival] = 0;
			    TextDrawHideForPlayer(playerid, TBlastSurvival);
			    TextDrawHideForPlayer(playerid, TTiempoRestante);
			    TextDrawHideForPlayer(playerid, TJugadores);
				TextDrawHideForPlayer(playerid, TTiempoRestante2);
				TextDrawHideForPlayer(playerid, TJugadores2);
				SetPlayerVirtualWorld(playerid, 0);
				SpawnPlayer(playerid);
				format(string,sizeof(string),"%d", BlastSurvival[playerjoined]);
				TextDrawSetString(TJugadores2, string);
				if(BlastSurvival[playerjoined] == 0)
				{
					AbrirBS = SetTimer("CargarBlastSurvival",1500000,1);
					SetTimer("SpawnearPlayer",3000,1);
					KillTimer(EmpezarBS);
				    BlastSurvival[started] = 0;
				    BlastSurvival[loaded] = 0;
				    if(BlastSurvival[usingcustomtimer] == 1) {BlastSurvival[timer] = BlastSurvival[savedtime];}
				    else {BlastSurvival[defaulttimer] = 150;}
				    KillTimer(ExplosionTimer);
				    BlastSurvival[playerjoined] = 0;
				    KillTimer(StopExplosion);
				    SendClientMessageToAll(red,"|Info| 認EAEAEA} El {919770}Blast Survival{EAEAEA} fue cancelado por falta de jugadores. Empezara otro en 25 minutos.");
				}
			}
        }
    }
    if(BlastSurvival[started] == 1)
    {
		if(pBlastSurvival[playerid][inblastsurvival] == 1)
	    {
			if(armour >= 100)
			{
				format(string, sizeof(string), "|Info| 認0080FF} %s {EAEAEA}fue expulsado del {919770}Blast Survival{EAEAEA} por recargar armadura.",pName,playerid);
				SendClientMessageToAll(red, string);
				BlastSurvival[playerjoined]--;
		  		pBlastSurvival[playerid][inblastsurvival] = 0;
			    TextDrawHideForPlayer(playerid, TBlastSurvival);
			    TextDrawHideForPlayer(playerid, TTiempoRestante);
			    TextDrawHideForPlayer(playerid, TJugadores);
				TextDrawHideForPlayer(playerid, TTiempoRestante2);
				TextDrawHideForPlayer(playerid, TJugadores2);
				SetPlayerVirtualWorld(playerid, 0);
				SpawnPlayer(playerid);
				format(string,sizeof(string),"%d", BlastSurvival[playerjoined]);
				TextDrawSetString(TJugadores2, string);
				if(BlastSurvival[playerjoined] == 0)
				{
					AbrirBS = SetTimer("CargarBlastSurvival",1500000,1);
					SetTimer("SpawnearPlayer",3000,1);
					KillTimer(EmpezarBS);
				    BlastSurvival[started] = 0;
				    BlastSurvival[loaded] = 0;
				    if(BlastSurvival[usingcustomtimer] == 1) {BlastSurvival[timer] = BlastSurvival[savedtime];}
				    else {BlastSurvival[defaulttimer] = 150;}
				    KillTimer(ExplosionTimer);
				    BlastSurvival[playerjoined] = 0;
				    KillTimer(StopExplosion);
				    SendClientMessageToAll(red,"|Info| 認EAEAEA} El {919770}Blast Survival{EAEAEA} fue cancelado por falta de jugadores. Empezara otro en 25 minutos.");
				}
			}
        }
    }
    return 1;
}

public OnStopExplosion(playerid)
{
	new string[128];
	if(BlastSurvival[stopped] == 1)
	{
		KillTimer(ExplosionTimer);
		KillTimer(StopExplosion);
		CheckWinner();
	}
	if(BlastSurvival[usingcustomtimer] == 1) {BlastSurvival[timer]--;}
	else {BlastSurvival[defaulttimer]--;}
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(pBlastSurvival[i][inblastsurvival] == 1)
		{
		    TextDrawHideForPlayer(i, TTiempoRestante2);
			if(BlastSurvival[usingcustomtimer] == 1) {format(string,sizeof(string),"%d",BlastSurvival[timer]);}
			else {format(string,sizeof(string),"%d",BlastSurvival[defaulttimer]);}
			TextDrawSetString(TTiempoRestante2, string);
			TextDrawShowForPlayer(i, TTiempoRestante2);
		}
	}
	if(BlastSurvival[usingcustomtimer] == 1)
	{
		if(BlastSurvival[timer] == -1) return BlastSurvival[stopped] = 1;
	}
	if(BlastSurvival[defaulttimer] == -1) return BlastSurvival[stopped] = 1;
	return 1;
}

public OnExplosionStarts(playerid)
{
	new rand = random(sizeof(gRandomExplosion));
	CreateExplosion(gRandomExplosion[rand][0],gRandomExplosion[rand][1],gRandomExplosion[rand][2],BlastSurvival[explotype],BlastSurvival[exploradius]);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(pBlastSurvival[playerid][isspectating] == 1)
	{
	    SetPlayerCameraPos(playerid, 1790.2144,-1947.2479,36.5027);
	    SetPlayerCameraLookAt(playerid, 1791.0,-1912.0,13.0);
	    SetPlayerPos(playerid, 1742.4601,-1905.1687,30.5651);
	    TogglePlayerControllable(playerid, 0);
		TextDrawShowForPlayer(playerid, TBlastSurvival);
        TextDrawShowForPlayer(playerid, TTiempoRestante);
        TextDrawShowForPlayer(playerid, TJugadores);
        TextDrawShowForPlayer(playerid, TTiempoRestante2);
		TextDrawShowForPlayer(playerid, TJugadores2);
	}
	return 1;
}

public SpawnearPlayer()
{
	for(new i=0; i<MAX_PLAYERS; i++)
 	{
 		if(pBlastSurvival[i][isspectating] == 1)
		{
			TextDrawHideForPlayer(i, TBlastSurvival);
			TextDrawHideForPlayer(i, TTiempoRestante);
			TextDrawHideForPlayer(i, TJugadores);
			TextDrawHideForPlayer(i, TTiempoRestante2);
			TextDrawHideForPlayer(i, TJugadores2);
			SetPlayerVirtualWorld(i, 0);
			SpawnPlayer(i);
			TogglePlayerControllable(i, 1);
			pBlastSurvival[i][isspectating] = 0;
    	}
    }
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp("/entrarblast", cmdtext, true, 14))
	{
		if(BlastSurvival[loaded] == 0) return SendClientMessage(playerid, red, "|Info| 認EAEAEA} El blast survival no esta activado.");
	    if(BlastSurvival[started] == 1) return SendClientMessage(playerid, red, "|Info| 認EAEAEA} El blast survival ya ha empezado, espera a que acabe.");
	    if(BlastSurvival[playerjoined] == BlastSurvival[playerlimit]) return SendClientMessage(playerid, red, "|Info| 認EAEAEA} El blast survival esta lleno.");
		if(pBlastSurvival[playerid][inblastsurvival] == 1) return SendClientMessage(playerid, red, "|Info| 認EAEAEA} Ya estas en el blast survival.");
		ResetPlayerWeapons(playerid);
		SetPlayerVirtualWorld(playerid, 69);
		SetPlayerCameraPos(playerid, 0, 0, 0);
		SetCameraBehindPlayer(playerid);
	    BlastSurvival[playerjoined]++;
	    pBlastSurvival[playerid][inblastsurvival] = 1;
	    SetPlayerArmour(playerid,99.0);
    	SetPlayerHealth(playerid,99.0);
		GameTextForPlayer(playerid, "~w~Esperando Jugadores...",10000,5);
		new rand = random(sizeof(gRandomStartSpot));
		SetPlayerPos(playerid, gRandomStartSpot[rand][0], gRandomStartSpot[rand][1], gRandomStartSpot[rand][2]);
		SetCameraBehindPlayer(playerid);
        TextDrawShowForPlayer(playerid, TBlastSurvival);
        TextDrawShowForPlayer(playerid, TTiempoRestante);
        TextDrawShowForPlayer(playerid, TJugadores);
        TextDrawShowForPlayer(playerid, TTiempoRestante2);
		TextDrawShowForPlayer(playerid, TJugadores2);
		new string[128];
		format(string,sizeof(string),"%d", BlastSurvival[playerjoined]);
		TextDrawSetString(TJugadores2, string);
		if(BlastSurvival[usingcustomtimer] == 1) format(string,sizeof(string),"%d",BlastSurvival[timer]);
		else format(string,sizeof(string),"%d",BlastSurvival[defaulttimer]);
		TextDrawSetString(TTiempoRestante2, string);
	    return 1;
	}
	if(!strcmp("/salirblast", cmdtext, true, 19))
	{
        if(BlastSurvival[started] == 1) return SendClientMessage(playerid, red, "|Info| 認EAEAEA} Ya no puedes dejar el blast survival.");
	    if(iscountactivated == 1) return SendClientMessage(playerid, red, "|Info| 認EAEAEA} Ya no puedes dejar el blast survival.");
		if(BlastSurvival[loaded] == 0) return SendClientMessage(playerid, red, "|Info| 認EAEAEA} El blast survival no esta activado.");
	    if(pBlastSurvival[playerid][inblastsurvival] == 0) return SendClientMessage(playerid, red, "|Info| 認EAEAEA} No estas en el blast survival.");
	    BlastSurvival[playerjoined]--;
	    pBlastSurvival[playerid][inblastsurvival] = 0;
	    TextDrawHideForPlayer(playerid, TBlastSurvival);
        TextDrawHideForPlayer(playerid, TTiempoRestante);
        TextDrawHideForPlayer(playerid, TJugadores);
		TextDrawHideForPlayer(playerid, TTiempoRestante2);
		TextDrawHideForPlayer(playerid, TJugadores2);
		SetPlayerVirtualWorld(playerid, 0);
		SpawnPlayer(playerid);
		new string[128];
		format(string,sizeof(string),"%d", BlastSurvival[playerjoined]);
		TextDrawSetString(TJugadores2, string);
	    return 1;
	}
	if(!strcmp("/CargarBS", cmdtext, true, 20))
	{
        AbrirBS = SetTimer("CargarBlastSurvival",10000,1);
		return 1;
	}
	return 0;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(pBlastSurvival[playerid][inblastsurvival] == 1)
		{
			if(BlastSurvival[playerjoined] > 1)
			{
				pBlastSurvival[playerid][isspectating] = 1;
				SetPlayerCameraPos(playerid, 1790.2144,-1947.2479,36.5027);
	    		SetPlayerCameraLookAt(playerid, 1791.0,-1912.0,13.0);
    			SetPlayerPos(playerid, 1742.4601,-1905.1687,30.5651);
	    		TogglePlayerControllable(playerid, 0);
	    		TextDrawShowForPlayer(playerid, TBlastSurvival);
        		TextDrawShowForPlayer(playerid, TTiempoRestante);
        		TextDrawShowForPlayer(playerid, TJugadores);
        		TextDrawShowForPlayer(playerid, TTiempoRestante2);
				TextDrawShowForPlayer(playerid, TJugadores2);
				new string[128];
				format(string,sizeof(string),"%d", BlastSurvival[playerjoined]);
				TextDrawSetString(TJugadores2, string);
				if(BlastSurvival[usingcustomtimer] == 1) format(string,sizeof(string),"%d",BlastSurvival[timer]);
				else format(string,sizeof(string),"%d",BlastSurvival[defaulttimer]);
				TextDrawSetString(TTiempoRestante2, string);
			}
			else {pBlastSurvival[playerid][isspectating] = 1;}
			BlastSurvival[playerjoined] -- ;
			pBlastSurvival[playerid][inblastsurvival] = 0;
		    static place;
		    place=BlastSurvival[playerjoined];
		    place++;
		    new string[128], pName[MAX_PLAYER_NAME];//,Prize[2];
			GetPlayerName(playerid, pName, sizeof(pName));
		    /*switch(place)
			{
			    case 1: Prize[0] = (random(random(1000)) + 19000), Prize[1] = 15;
			    case 2: Prize[0] = (random(random(1000)) + 17000), Prize[1] = 13;
			    case 3: Prize[0] = (random(random(1000)) + 15000), Prize[1] = 11;
			    case 4: Prize[0] = (random(random(1000)) + 13000), Prize[1] = 9;
			    case 5: Prize[0] = (random(random(1000)) + 11000), Prize[1] = 7;
			    case 6: Prize[0] = (random(random(1000)) + 9000), Prize[1] = 5;
			    case 7: Prize[0] = (random(random(1000)) + 7000), Prize[1] = 3;
			    case 8: Prize[0] = (random(random(1000)) + 5000), Prize[1] = 2;
			    case 9: Prize[0] = (random(random(1000)) + 3000), Prize[1] = 2;
			    default: Prize[0] = random(random(1000)), Prize[1] = 2;
			}*/
			format(string,sizeof(string),"|Info| 認0080FF} %s {EAEAEA}termino el {919770}Blast Survival{EAEAEA} en la posici鏮 {00CCFF}#%d.",pName,BlastSurvival[playerjoined]+1,(place == 1) ? ("st") : (place == 2) ? ("nd") : (place == 3) ? ("rd") : ("th"));
			SendClientMessageToAll(red,string);
			//new Premio[60];
 			//format(Premio,sizeof(Premio),"~w~Premio:~n~~y~$%d~n~~w~+~n~~r~%d Score", Prize[0], Prize[1]);
 			//GameTextForPlayer(playerid,Premio,5000,3);
 			//SendClientMessage(playerid, red, Premio);
 			//GivePlayerMoney(playerid, Prize[0]);
			//SetPlayerScore(playerid, GetPlayerScore(playerid) + Prize[1]);
 			//GivePlayerMoney((place == 1), 100000);
			{
			    if(BlastSurvival[playerjoined] == 0)
			    {
					AbrirBS = SetTimer("CargarBlastSurvival",1500000,1);
					SetTimer("SpawnearPlayer",3000,1);
					KillTimer(CountTimer);
					BlastSurvival[started] = 0;
					SendClientMessageToAll(red,"|Info| 認EAEAEA} El {919770}Blast Survival{EAEAEA} ha terminado. Empezara otro en 25 minutos.");
				}
			}
			BlastSurvival[loaded]=0;
			BlastSurvival[started]=0;
			if(BlastSurvival[usingcustomtimer] == 1)
			{
				BlastSurvival[timer] = BlastSurvival[savedtime];
			}
			else {BlastSurvival[defaulttimer] = 150;}
			TextDrawHideForPlayer(playerid, TBlastSurvival);
            TextDrawHideForPlayer(playerid, TTiempoRestante);
            TextDrawHideForPlayer(playerid, TJugadores);
			TextDrawHideForPlayer(playerid, TTiempoRestante2);
			TextDrawHideForPlayer(playerid, TJugadores2);
			if(BlastSurvival[playerjoined] == 0)
			{
				pBlastSurvival[playerid][inblastsurvival] = 0;
				BlastSurvival[loaded]=0;
				BlastSurvival[started]=0;
				if(BlastSurvival[usingcustomtimer] == 1)
				{
					BlastSurvival[timer] = BlastSurvival[savedtime];
				}
				else {BlastSurvival[defaulttimer] = 150;}
				KillTimer(ExplosionTimer);
				KillTimer(StopExplosion);
				BlastSurvival[playerjoined] = 0;
				return 1;
   			}
			if(BlastSurvival[playerjoined] == 1)
			{
		    	pBlastSurvival[playerid][isspectating] = 1;
				pBlastSurvival[playerid][inblastsurvival] = 0;
				BlastSurvival[loaded]=0;
				BlastSurvival[started]=0;
				if(BlastSurvival[usingcustomtimer] == 1){BlastSurvival[timer] = BlastSurvival[savedtime];}
				else {BlastSurvival[defaulttimer] = 150;}
				KillTimer(ExplosionTimer);
				KillTimer(StopExplosion);
				CheckWinner();
				BlastSurvival[playerjoined] = 0;
				return 1;
   			}
			format(string,sizeof(string),"%s", BlastSurvival[playerjoined]);
			TextDrawSetString(TJugadores2, string);
			TextDrawHideForPlayer(playerid, TBlastSurvival);
            TextDrawHideForPlayer(playerid, TTiempoRestante);
            TextDrawHideForPlayer(playerid, TJugadores);
			TextDrawHideForPlayer(playerid, TTiempoRestante2);
			TextDrawHideForPlayer(playerid, TJugadores2);
			SetPlayerVirtualWorld(playerid, 0);
		}
    }
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(pBlastSurvival[playerid][inblastsurvival])
	{
	    pBlastSurvival[playerid][inblastsurvival]=0;
	    BlastSurvival[playerjoined]--;
	}
	return 1;
}

public Count()
{
    if(!iscountactivated)
	{
		KillTimer(CountTimer);
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(pBlastSurvival[i][inblastsurvival] == 1)
			{
				TogglePlayerControllable(i, 1);
			}
		}
		StopExplosion = SetTimer("OnStopExplosion",1000,true);
		ExplosionTimer = SetTimer("OnExplosionStarts",1500,true);
	}
    else
    {
        new string[4];
        format(string,sizeof(string),"%i",countamount);
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(pBlastSurvival[i][inblastsurvival] == 1)
			{
				TogglePlayerControllable(i, 0);
        		GameTextForPlayer(i,string,1000,5);
        		PlayerPlaySound(i, 1056, 0, 0, 0);
			}
		}
		countamount--;
        if(countamount == -1)
		{
			iscountactivated = 0;
			for(new i=0; i<MAX_PLAYERS; i++)
			{
				if(pBlastSurvival[i][inblastsurvival] == 1)
				{
					GameTextForPlayer(i,"~w~GO GO GO!",1000,5);
					PlayerPlaySound(i, 1057, 0, 0, 0);
				}
			}
		}
    }
    return 1;
}

public CheckWinner()
{
	if(BlastSurvival[playerjoined] > 1)
	{
	    for(new i=0; i<MAX_PLAYERS; i++)
	    {
        SpawnPlayer(i);
        SetPlayerVirtualWorld(i, 0);
        pBlastSurvival[i][inblastsurvival]=0;
        BlastSurvival[playerjoined]=0;
        TextDrawHideForPlayer(i, TBlastSurvival);
        TextDrawHideForPlayer(i, TTiempoRestante);
        TextDrawHideForPlayer(i, TJugadores);
		TextDrawHideForPlayer(i, TTiempoRestante2);
		TextDrawHideForPlayer(i, TJugadores2);
		}
		AbrirBS = SetTimer("CargarBlastSurvival",1500000,1);
		SetTimer("SpawnearPlayer",3000,1);
		SendClientMessageToAll(red, "|Info| 認EAEAEA} Nadie gano el {919770}Blast Survival.{EAEAEA} Empezara otro en 25 minutos.");
		return 1;
	}
	BlastSurvival[playerjoined]=0;
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(pBlastSurvival[i][inblastsurvival])
	    {
			new string[128], pName[MAX_PLAYER_NAME+1];
			new playerid;
   			GetPlayerName(i, pName, sizeof(pName));
   			KillTimer(CountTimer);
   			AbrirBS = SetTimer("CargarBlastSurvival",900000,1);
   			SetTimer("SpawnearPlayer",3000,1);
			format(string,sizeof(string),"|Info| 認0080FF} %s {EAEAEA}gano el {919770}Blast Survival.{EAEAEA} Empezara otro en 25 minutos.",pName);
			SendClientMessageToAll(red, string);
			SetPlayerScore(playerid, GetPlayerScore(playerid) + 15);
 			GivePlayerMoney(playerid, 100000);
			GameTextForPlayer(playerid,"~w~Premio:~n~~y~$100000~n~~w~+~n~~r~15 Score",5000,3);
 			SendClientMessage(playerid, red, "~w~Premio:~n~~y~$100000~n~~w~+~n~~r~15 Score");
			pBlastSurvival[i][inblastsurvival]=0;
			TextDrawHideForPlayer(i, TBlastSurvival);
            TextDrawHideForPlayer(i, TTiempoRestante);
            TextDrawHideForPlayer(i, TJugadores);
			TextDrawHideForPlayer(i, TTiempoRestante2);
			TextDrawHideForPlayer(i, TJugadores2);
			SpawnPlayer(i);
			SetPlayerVirtualWorld(i, 0);
		}
	}
	if(BlastSurvival[usingcustomtimer] == 1){BlastSurvival[timer] = BlastSurvival[savedtime];}
	else {BlastSurvival[defaulttimer] = 150;}
	BlastSurvival[loaded] = 0;
	BlastSurvival[started] = 0;
	return 1;
}
