/*
				traduccion centineL fs por monkey
*/

#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>
#include <foreach>
//#include <YSI-Includes\YSI\y_iterate>

/*#define isodd(%1) \
	((%1) & 0x01)

#define iseven(%1) \
	(!isodd((%1)))*/

#define ALL_PLAYERS 	200     //Define number of players on your server
#define MAX_SLOTS 		54      //Don't change this

#define PRIZE_MONEY 	10000

#define LIME 		0x88AA62FF
#define WHITE 		0xFFFFFFAA
#define RULE 		0xFBDF89AA
#define ORANGE 		0xDB881AAA

#define COL_LIME    \
	"{88AA62}"
#define COL_WHITE 	\
	"{FFFFFF}"
#define COL_RULE   	\
	"{FBDF89}"
#define COL_ORANGE	\
	"{DB881A}"

forward SpeedUp( object, Float:x, Float:y, Float:z);
forward RespawnPlayer( player );
forward MinigameWinner( player );
forward MinigameCountdown( );
forward MinigameUpdate( );
forward EndMinigame( );

new bool:Minigamer_[ALL_PLAYERS char];
new bool:VIEW_FROM_ABOVE;
new inProgress, uTimer;
new Objects_[2][MAX_SLOTS];
new pWeaponData[ALL_PLAYERS][13];
new pSavedAmmo[ALL_PLAYERS][13];
new Float:pCoords[ALL_PLAYERS][3];
new pInterior[ALL_PLAYERS];

new Iterator:_Minigamer	<MAX_SLOTS>;
new Iterator:_Objects	<MAX_SLOTS>;

new pReadyText[4][64] =
{
	"~n~ ~n~ ~n~ ~y~Estas Listo ?...",
	"~n~ ~n~ ~n~ ~y~Preparate!",
	"~n~ ~n~ ~n~ ~y~Cuidado con mojarte",
	"~n~ ~n~ ~n~ ~y~Evita Caerte"
};



new pFellOffText[5][28] =
{
	"~n~ ~r~manguera",
	"~n~ ~r~todo mojado",
	"~n~ ~r~no nades",
	"~n~ ~r~te estas ahogando !",
	"~n~ ~r~Aguaaa"
};

new Float:gCoords[MAX_SLOTS][3] = {
	
	{ -5309.198120,-199.052383,22.593704 },
	{ -5309.198120,-195.786071,22.593704 },
	{ -5309.198120,-192.510620,22.593704 },
	{ -5309.198120,-189.250564,22.593704 },
	{ -5309.198120,-185.987960,22.593704 },
	{ -5309.198120,-182.727081,22.593704 },
	{ -5309.198120,-179.463394,22.593704 },
	{ -5309.198120,-176.205261,22.593704 },
	{ -5304.841796,-176.205261,22.593704 },
	{ -5304.841796,-179.468795,22.593704 },
	{ -5304.841796,-182.737884,22.593704 },
	{ -5304.841796,-185.989654,22.593704 },
	{ -5304.841796,-189.259185,22.593704 },
	{ -5304.841796,-192.518615,22.593704 },
	{ -5304.841796,-195.785491,22.593704 },
	{ -5304.841796,-199.054733,22.593704 },
	{ -5300.489990,-199.054733,22.593704 },
	{ -5300.489990,-195.782165,22.593704 },
	{ -5300.489990,-192.531250,22.593704 },
	{ -5300.489990,-189.274765,22.593704 },
	{ -5300.489990,-186.003005,22.593704 },
	{ -5300.489990,-182.735229,22.593704 },
	{ -5300.489990,-179.471069,22.593704 },
	{ -5300.489990,-176.208007,22.593704 },
	{ -5296.138061,-176.208007,22.593704 },
	{ -5296.138061,-179.479248,22.593704 },
	{ -5296.138061,-182.744735,22.593704 },
	{ -5296.138061,-186.002944,22.593704 },
	{ -5296.138061,-189.274505,22.593704 },
	{ -5296.138061,-192.533691,22.593704 },
	{ -5296.138061,-195.788970,22.593704 },
	{ -5296.138061,-199.048782,22.593704 },
	{ -5291.776000,-199.050140,22.593704 },
	{ -5291.776000,-195.790634,22.593704 },
	{ -5291.776000,-192.542922,22.593704 },
	{ -5291.776000,-189.277542,22.593704 },
	{ -5291.776000,-186.013275,22.593704 },
	{ -5291.776000,-182.742355,22.593704 },
	{ -5291.776000,-179.475021,22.593704 },
	{ -5291.776000,-176.215805,22.593704 },
	{ -5287.432250,-176.215805,22.593704 },
	{ -5287.432250,-179.485168,22.593704 },
	{ -5287.432250,-182.739608,22.593704 },
	{ -5287.432250,-186.016723,22.593704 },
	{ -5287.432250,-189.277816,22.593704 },
	{ -5287.432250,-192.539001,22.593704 },
	{ -5287.432250,-195.796325,22.593704 },
	{ -5287.432250,-199.053771,22.593704 },
	{ -5287.431274,-202.320648,22.593704 },
	{ -5291.781616,-202.320648,22.593704 },
	{ -5296.136718,-202.320648,22.593704 },
	{ -5300.493652,-202.320648,22.593704 },
	{ -5304.848876,-202.320648,22.593704 },
	{ -5309.201660,-202.320648,22.593704 }
};

public OnFilterScriptInit( )
{
	return 1;
}

public OnFilterScriptExit( )
{
    if( inProgress > 0 ) EndMinigame( );
	return 1;
}

public OnPlayerDisconnect( playerid, reason )
{
    new str[128];
	if( Minigamer_{ playerid } == true )
	{
		if( inProgress > 1 )
		{
   			format( str, sizeof( str ), "{88AA62}* %s "COL_RULE"{88AA62}ha abandonado el "COL_ORANGE"{DB881A}minijuego "COL_RULE"{DB881A}no te mojes getwet "COL_LIME"{FFFFFF}rank %d", PlayerName( playerid ), Iter_Count(_Minigamer ) );
			SendClientMessageToAll( LIME, str );
			Iter_Remove(_Minigamer, playerid );
			Minigamer_{ playerid } = false;
			if( Iter_Count(_Minigamer ) < 2 )
			{
			    foreach(_Minigamer, i ) MinigameWinner( i );
			}
		}
		else
		{
		    Iter_Remove(_Minigamer, playerid );
			Minigamer_{ playerid } = false;
		}
	}
	return 1;
}

public OnPlayerDeath( playerid, killerid, reason )
{
    new str[128];
	if( Minigamer_{ playerid } == true )
	{
		if( inProgress > 1 )
		{
   			format( str, sizeof( str ), "{88AA62}* %s "COL_RULE"{88AA62}ha abandonado el "COL_ORANGE"{DB881A}minijuego "COL_RULE"{DB881A}no te mojes getwet "COL_LIME"{FFFFFF}rank %d", PlayerName( playerid ), Iter_Count(_Minigamer ) );
			SendClientMessageToAll( LIME, str );
			Iter_Remove(_Minigamer, playerid );
			Minigamer_{ playerid } = false;
			if( Iter_Count(_Minigamer ) < 2 )
			{
			    foreach(_Minigamer, i ) MinigameWinner( i );
			}
		}
		else
		{
			SendClientMessage( playerid, LIME, "Tu puesto para "COL_ORANGE"Getwet"COL_LIME" minijuego ha sido cancelado" );
			Iter_Remove(_Minigamer, playerid );
			Minigamer_{ playerid } = false;
		}
	}
	return 1;
}

CMD:getwet( playerid, params[] )
{
    if( GetPlayerState( playerid ) == PLAYER_STATE_WASTED )
		return SendClientMessage( playerid, LIME, "Comando es temporal deshabilitado porque estï¿½s perdido." );
	else if( Minigamer_{ playerid } != false )
		return SendClientMessage( playerid, LIME, "Usted ya ha firmado para "COL_ORANGE"Getwet "COL_LIME" minijuego." );
	else if( inProgress > 1 )
		return SendClientMessage( playerid, ORANGE, "Getwet"COL_LIME" minijuego se encuentra actualmente en curso, espere por favor." );
	else if( Iter_Count(_Minigamer ) > MAX_SLOTS-1 )
		return SendClientMessage( playerid, ORANGE,"Getwet"COL_LIME" minijuego ya estï¿½ lleno. Por favor espere hasta que termine." );
    if( inProgress < 1 )
    {
	    if( strcmp( params, "1", true ) == 0 )
	    VIEW_FROM_ABOVE = true;
	    else if( strcmp( params, "2", true ) == 0 )
		VIEW_FROM_ABOVE = false;
	    else return SendClientMessage( playerid, WHITE, "Usa: /getwet [1 o 2]" );

		new str[128];
		Minigamer_{ playerid } = true;
		Iter_Add(_Minigamer, playerid );
		format( str, sizeof( str ), "Getwet  v.%i.0 "COL_ORANGE"minijuego comenzarï¿½ en 20 segundos. Pon "COL_LIME"/getwet "COL_RULE"para entrar.", strval(params) );
		SendClientMessageToAll( LIME, str );
		SetTimer( "MinigameCountdown", 20000, 0 );
		for( new i; i < MAX_SLOTS; i++ )
	    {
	        //The object (window) is only visible from one side
			Objects_[0][i] = CreateObject( 1649, gCoords[i][0], gCoords[i][1], gCoords[i][2], -90.000000, 0.000000, 0.000000, 150.0 );
			if(!VIEW_FROM_ABOVE) //In case /getwet 2, we need to multiply number of objects and turn them around so players would be able to see them from below
			Objects_[1][i] = CreateObject( 1649, gCoords[i][0], gCoords[i][1], gCoords[i][2], -270.000000, 0.000000, 0.000000, 150.0 );
			Iter_Add(_Objects, i );
	    }
	    inProgress = 1;
    }
    else
    {
    	Minigamer_{ playerid } = true;
 		Iter_Add(_Minigamer, playerid );
		SendClientMessage( playerid, RULE,"Se han inscrito para "COL_ORANGE" Getwet"COL_RULE" minijuego." );
	}
	return 1;
}

public MinigameCountdown( )
{
	if( Iter_Count(_Minigamer ) < 1 ) //End minigame if there aren't enough sign ups
	{
		SendClientMessageToAll( LIME,"No había suficientes jugadores para empezar "COL_ORANGE"Getwet"COL_LIME" minijuego." );
		foreach(_Minigamer, i) Minigamer_{ i } = false;
		return EndMinigame( );
	}
	if( inProgress != 2 )
	{
	    new spot;
		foreach(_Minigamer, i )
		{
     		GetPlayerPos( i, pCoords[i][0], pCoords[i][1], pCoords[i][2]);
     		pInterior[i] = GetPlayerInterior( i );
     		for( new a; a < 13; a++ )
			{
		      	GetPlayerWeaponData( i, a, pWeaponData[i][a], pSavedAmmo[i][a] );
  			}
			ResetPlayerWeapons( i );
			SetPlayerInterior( i, 0 );
			spot = Iter_Random(_Objects );
     		GameTextForPlayer( i, pReadyText[ random( sizeof( pReadyText ) ) ], 2050, 3 );
     		Iter_Remove(_Objects, spot );
     		SetPlayerCameraPos( i, -5298.4814,-218.4391,42.1386);
     		SetPlayerCameraLookAt( i, -5298.1616,-189.6903,23.6564);
     		TogglePlayerControllable( i, false );
			SetPlayerPos( i, gCoords[spot][0], gCoords[spot][1], gCoords[spot][2] +0.5 );
		}
		Iter_Clear(_Objects);
		for( new i; i < MAX_SLOTS; i++ ) Iter_Add(_Objects, i );
		SetTimer( "MinigameCountdown", 2000, 0 );
		inProgress = 2;
	}
	else
	{
		foreach(_Minigamer, i )
		{
		    if(!VIEW_FROM_ABOVE)
			SetCameraBehindPlayer( i );
			PlayerPlaySound( i, 1057, 0.0, 0.0, 0.0 );
			TogglePlayerControllable( i, true );
		}
		uTimer = SetTimer( "MinigameUpdate", 2500, 1 );
	}
	return 1;
}

public MinigameUpdate( )
{
	if( Iter_Count(_Minigamer ) < 1 ) return EndMinigame( );
	
	new str[128], Float:playerx, Float:playery, Float:playerz[ALL_PLAYERS];
	foreach(_Minigamer, i )
	{
		GetPlayerPos( i, playerx, playery, playerz[i] );
		if( playerz[i] < 2.0 ) //Checks if player is in the water
		{
			format( str, sizeof( str ), "* %s "COL_RULE"ha abandonado el "COL_ORANGE"minijuego "COL_RULE"Getwet "COL_LIME"rank %d", PlayerName( i ), Iter_Count(_Minigamer ) );
			SendClientMessageToAll( LIME, str );
			GameTextForPlayer( i, pFellOffText[ random( sizeof( pFellOffText ) ) ], 2500, 3 );
			Iter_Remove(_Minigamer, i );
			Minigamer_{ i } = false;
			RespawnPlayer( i );
		}
	}
	if( Iter_Count(_Minigamer ) < 2 )
	{
 		foreach(_Minigamer, i ) MinigameWinner( i );
	}
 	new objectid, Float:ObjectX, Float:ObjectY, Float:ObjectZ;

    if(!VIEW_FROM_ABOVE)
    {
	 	foreach(_Objects, i )
		{
			if( isodd( random( 10 ) ) )
			{
		 	    GetObjectPos( Objects_[0][i], ObjectX, ObjectY, ObjectZ );
				MoveObject( Objects_[0][i], ObjectX, ObjectY, ObjectZ -1.5, 0.2 );
	   			MoveObject( Objects_[1][i], ObjectX, ObjectY, ObjectZ -1.5, 0.2 );
			}
			else
			{
				GetObjectPos( Objects_[0][i], ObjectX, ObjectY, ObjectZ );
				MoveObject( Objects_[0][i], ObjectX, ObjectY, ObjectZ +1.5, 0.2 );
				MoveObject( Objects_[1][i], ObjectX, ObjectY, ObjectZ +1.5, 0.2 );
			}
		}
	}

 	objectid = Iter_Random(_Objects );
	GetObjectPos( Objects_[0][objectid], ObjectX, ObjectY, ObjectZ );
	SetTimerEx("SpeedUp", 500, 0, "ifff", objectid, ObjectX, ObjectY, ObjectZ);
	MoveObject( Objects_[0][objectid], ObjectX, ObjectY, ObjectZ -5, 1 );
	if(!VIEW_FROM_ABOVE)
	MoveObject( Objects_[1][objectid], ObjectX, ObjectY, ObjectZ -5, 1 );
    Iter_Remove(_Objects, objectid );
	return 1;
}

public SpeedUp( object, Float:x, Float:y, Float:z )
{
	MoveObject( Objects_[0][object], x, y, z -150, 20 );
	if(!VIEW_FROM_ABOVE)
	MoveObject( Objects_[1][object], x, y, z -150, 20 );
	foreach(_Minigamer, i ) PlayerPlaySound( i, 1039, 0.0, 0.0, 0.0 );
}

public EndMinigame( )
{
	for( new i; i < MAX_SLOTS; i++ )
 	{
 	    DestroyObject( Objects_[0][i] );
 	    if(!VIEW_FROM_ABOVE)
 	    DestroyObject( Objects_[1][i] );
 	}
 	inProgress = 0;
	Iter_Clear(_Objects );
	Iter_Clear(_Minigamer );
	KillTimer( uTimer );
	return 1;
}

public MinigameWinner( player )
{
	new str[128];
	format( str, sizeof( str ), "* %s "COL_RULE"ha ganado "COL_ORANGE"el minijuego "COL_RULE"Getwet y gana +3 de score", PlayerName( player ) );
	SendClientMessageToAll( LIME, str );
	SetPlayerScore(player, GetPlayerScore(player)+3);
 	GivePlayerMoney( player, PRIZE_MONEY );
 	Minigamer_{ player } = false;
	Iter_Remove(_Minigamer, player );
	SetTimerEx( "RespawnPlayer", 1400, 0, "i", player );
	SetTimer( "EndMinigame", 1700, 0);
}

public RespawnPlayer ( player )
{
	for( new i = 12; i > -1; i-- )
	{
		GivePlayerWeapon( player, pWeaponData[player][i], pSavedAmmo[player][i] );
	}
	SetPlayerPos( player, pCoords[player][0], pCoords[player][1], pCoords[player][2] );
   	SetPlayerInterior( player, pInterior[player] );
   	SetCameraBehindPlayer( player );
}

stock PlayerName( playerid )
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName( playerid, Name, sizeof( Name ) );
	return Name;
}
