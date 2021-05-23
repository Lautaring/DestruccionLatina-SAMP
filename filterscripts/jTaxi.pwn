/*                                                      Taxi job script by Jstylezzz
															Keep the credits!
        							  						   Version 1.2

When on foot, use /duty to go on duty as a taxi driver, when you have a customer, use /fare to start the fare.
If you need to spawn a taxi, use /spawntaxi (can be disabled).
																
								                               																				*/


#include <a_samp> //Credits to the SA-MP Team
#include <zcmd> //Credits to Zeex
#include <colors> //Credits to Oxside
#include <getvehicledriver> //Credits to Smeti

#define STARTAMOUNT 2.66 //This is the starting amount for the fare, remember, enter is as a float, ex. 1.23
#define MONEYPER100 1.00 //This is the amount of money the customer has to pay each 100 meters, remember, enter as a float, ex. 1.23
#define ScriptVersion "1.2"//Do not change, this is for my reference.
#define AllowTaxiSpawn  //Comment this line if you don't want to allow the /spawntaxi command.
#define DESIGN_NUMBER 2 //Change the number according to the design you want, refer to the release thread for pictures of the designs

//===NEW'S====//
new Text:ScreenCorner1;
new Text:ScreenCorner2;
new Text:ScreenCorner3;
new Text:ScreenCorner4;
new Text:ClockBase;
new Text:ClockScreen;
new Text:BackLight;
new Text:taxiblackbox[MAX_PLAYERS];
new Text:taxigreendisplay[MAX_PLAYERS];
new Text:taxitimedisplay[MAX_PLAYERS];
new Text:taxi100mfare[MAX_PLAYERS];
new Text:taxithisfare[MAX_PLAYERS];
new Text:taxilstlogo[MAX_PLAYERS];
new Text:taxistatus[MAX_PLAYERS];
new Text:startfare[MAX_PLAYERS];
new IsOnFare[MAX_PLAYERS];
new OnDuty[MAX_PLAYERS];
new clockupdate;
new faretimer[MAX_PLAYERS];
new Float:OldX[MAX_PLAYERS],Float:OldY[MAX_PLAYERS],Float:OldZ[MAX_PLAYERS],Float:NewX[MAX_PLAYERS],Float:NewY[MAX_PLAYERS],Float:NewZ[MAX_PLAYERS];
new Float:TotalFare[MAX_PLAYERS];
new Text:yourdriver[MAX_PLAYERS];
new Text:drivername[MAX_PLAYERS];
new HideID[MAX_PLAYERS];
//
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	printf(" 	Jstylezzz's Taxi Script\n  	 Version %s",ScriptVersion);
	print("--------------------------------------\n");
	CheckDesign();
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(faretimer[playerid]);
    OnDuty[playerid] = 0;
    IsOnFare[playerid] = 0;
	TotalFare[playerid] = 0.0;
	return 1;
}



public OnPlayerExitVehicle(playerid, vehicleid)
{
	
    new driver = GetVehicleDriver(vehicleid);
    HideID[playerid] = driver;
	if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER && TotalFare[driver] > 0)
	{
		new money = floatround(TotalFare[driver]/GetNumOfPassengers(driver)); //We split the cash over the passengers
		new message[128];
	    format(message,sizeof(message),"Has pagado %d $ al conductor del taxi",money);
		GivePlayerMoney(playerid,-money);
		TotalFare[driver] = 0;
		TextDrawSetString(taxithisfare[driver],"Total Tarifa: N/A");
		GivePlayerMoney(driver,money);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,message);
		format(message,sizeof(message),"%s a pagado %d $ por el paseo.",GetPlayerNameEx(playerid),money);
		SendClientMessage(driver,COLOR_LIGHTBLUE,message);
		TotalFare[driver] = 0.00;
		IsOnFare[driver] = 0;
		KillTimer(faretimer[driver]);
	}
    
 	TextDrawSetString(taxistatus[driver],"Taxi Status: Free");

	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new vehicleid = GetPlayerVehicleID(playerid);
    new driver = GetVehicleDriver(vehicleid);
    new name[MAX_PLAYER_NAME];
	format(name,sizeof(name),"%s",GetFirstName(driver));
    if(newstate == PLAYER_STATE_DRIVER)
	{

			if(OnDuty[playerid] == 1 && IsATaxi(vehicleid) == 1)
			{

				TextDrawShowForPlayer(playerid, taxiblackbox[playerid]);
				TextDrawShowForPlayer(playerid, taxigreendisplay[playerid]);
				TextDrawShowForPlayer(playerid, taxitimedisplay[playerid]);
				TextDrawShowForPlayer(playerid, taxi100mfare[playerid]);
				TextDrawShowForPlayer(playerid, startfare[playerid]);
				TextDrawShowForPlayer(playerid, taxithisfare[playerid]);
				TextDrawShowForPlayer(playerid, taxilstlogo[playerid]);
				TextDrawShowForPlayer(playerid, taxistatus[playerid]);
				#if DESIGN_NUMBER == 2
                    CheckDesign();
					TextDrawShowForPlayer(playerid, drivername[playerid]);
				    TextDrawShowForPlayer(playerid, yourdriver[driver]);
				    TextDrawShowForPlayer(playerid, ClockBase);
				    TextDrawShowForPlayer(playerid, ClockScreen);
				    TextDrawShowForPlayer(playerid, BackLight);
			     	TextDrawShowForPlayer(playerid, ScreenCorner1);
				    TextDrawShowForPlayer(playerid, ScreenCorner2);
				    TextDrawShowForPlayer(playerid, ScreenCorner3);
				    TextDrawShowForPlayer(playerid, ScreenCorner4);
				    TextDrawSetString(drivername[driver],name);
				#endif
			}
	}
	if(newstate == PLAYER_STATE_PASSENGER)
	{
		if(OnDuty[driver] == 1)
		{

			TextDrawShowForPlayer(playerid, taxiblackbox[driver]);
			TextDrawShowForPlayer(playerid, taxigreendisplay[driver]);
			TextDrawShowForPlayer(playerid, taxitimedisplay[driver]);
			TextDrawShowForPlayer(playerid, taxi100mfare[driver]);
			TextDrawShowForPlayer(playerid, taxithisfare[driver]);
			TextDrawShowForPlayer(playerid, taxilstlogo[driver]);
		    TextDrawSetString(taxistatus[driver],"Estado del Taxi: Ocupado");
			TextDrawShowForPlayer(playerid, taxistatus[driver]);
			TextDrawShowForPlayer(playerid, startfare[driver]);
			#if DESIGN_NUMBER == 2
                CheckDesign();
			    TextDrawShowForPlayer(playerid, drivername[playerid]);
			    TextDrawShowForPlayer(playerid, yourdriver[driver]);
			    TextDrawShowForPlayer(playerid, ClockBase);
			    TextDrawShowForPlayer(playerid, ClockScreen);
			    TextDrawShowForPlayer(playerid, BackLight);
			    TextDrawShowForPlayer(playerid, ScreenCorner1);
			    TextDrawShowForPlayer(playerid, ScreenCorner2);
			    TextDrawShowForPlayer(playerid, ScreenCorner3);
			    TextDrawShowForPlayer(playerid, ScreenCorner4);
			    TextDrawSetString(drivername[driver],name);
			#endif

		}
	}
 	if(newstate == PLAYER_STATE_ONFOOT)
	{
	    TextDrawHideForPlayer(playerid, ScreenCorner1);
	    TextDrawHideForPlayer(playerid, ScreenCorner2);
	    TextDrawHideForPlayer(playerid, ScreenCorner3);
	    TextDrawHideForPlayer(playerid, ScreenCorner4);
	    TextDrawHideForPlayer(playerid, ClockBase);
	    TextDrawHideForPlayer(playerid, ClockScreen);
	    TextDrawHideForPlayer(playerid, BackLight);
	    TextDrawHideForPlayer(playerid, drivername[HideID[playerid]]);
	    TextDrawHideForPlayer(playerid, yourdriver[HideID[playerid]]);
	    TextDrawHideForPlayer(playerid, taxiblackbox[HideID[playerid]]);
		TextDrawHideForPlayer(playerid, taxigreendisplay[HideID[playerid]]);
		TextDrawHideForPlayer(playerid, taxitimedisplay[HideID[playerid]]);
		TextDrawHideForPlayer(playerid, taxi100mfare[HideID[playerid]]);
		TextDrawHideForPlayer(playerid, taxithisfare[HideID[playerid]]);
		TextDrawHideForPlayer(playerid, taxilstlogo[HideID[playerid]]);
		TextDrawHideForPlayer(playerid, taxistatus[HideID[playerid]]);
		TextDrawHideForPlayer(playerid, startfare[HideID[playerid]]);
	    TextDrawSetString(drivername[driver],"N/A");
	    
        
	    if(IsOnFare[playerid] == 1)
		{


			SendClientMessage(playerid,COLOR_LIGHTBLUE,"Taxi duty over - You exited the vehicle!");
			OnDuty[playerid] = 0;
			TotalFare[playerid] = 0.00;
		 	TextDrawSetString(taxithisfare[playerid],"N/A");
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"La Tarifa se detuvo");
			IsOnFare[playerid] = 0;
			KillTimer(faretimer[playerid]);
			TextDrawDestroy(taxiblackbox[playerid]);
			TextDrawDestroy(taxigreendisplay[playerid]);
			TextDrawDestroy(taxitimedisplay[playerid]);
			TextDrawDestroy(taxi100mfare[playerid]);
			TextDrawDestroy(taxithisfare[playerid]);
			TextDrawDestroy(taxilstlogo[playerid]);
			TextDrawDestroy(taxistatus[playerid]);
			TextDrawDestroy(startfare[playerid]);
			TextDrawDestroy(taxiblackbox[driver]);
			TextDrawDestroy(taxigreendisplay[driver]);
			TextDrawDestroy(taxitimedisplay[driver]);
			TextDrawDestroy(taxi100mfare[driver]);
			TextDrawDestroy(taxithisfare[driver]);
			TextDrawDestroy(taxilstlogo[driver]);
			TextDrawDestroy(taxistatus[driver]);
			TextDrawDestroy(startfare[driver]);



		}
	}
	return 1;
}

//==COMMANDS==//
CMD:tarifa(playerid,params[])
{
	if(OnDuty[playerid] == 0) return SendClientMessage(playerid,COLOR_RED,"Usted no esta en servicio");
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsATaxi(vehicleid)) return SendClientMessage(playerid,COLOR_RED,"Usted necesita estar en un taxi para hacer esto!");
	if(GetPlayerVehicleSeat(playerid) != 0) return SendClientMessage(playerid,COLOR_RED,"Tienes que ser el conductor para hacer esto!");
	if(CheckPassengers(vehicleid) != 1) return SendClientMessage(playerid,COLOR_RED,"No abuse de su trabajo! Esperar a que alguien se interponga en el taxi!");
	if(IsOnFare[playerid] == 0)
	{
	
		if(IsOnFare[playerid] == 1) return SendClientMessage(playerid,COLOR_LIGHTBLUE,"Ya se encuentra en una tarifa");
		GetPlayerPos(playerid,Float:OldX[playerid],Float:OldY[playerid],Float:OldZ[playerid]);
		faretimer[playerid] = SetTimerEx("FareUpdate", 1000, true, "i", playerid);
		IsOnFare[playerid] = 1;
		TotalFare[playerid] = STARTAMOUNT;
		new formatted[128];
		format(formatted,128,"Total Fare: %.2f $",STARTAMOUNT);
		TextDrawSetString(taxithisfare[playerid],formatted);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"hora se encuentra en una tarifa, lleve a su cliente a su/el lugar deseado!");
		return 1;
	}
	if(IsOnFare[playerid] == 1)
	{
		TotalFare[playerid] = 0.00;
		TextDrawSetString(taxithisfare[playerid],"Total Tarifa: N/A");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"La tarifa se detuvo");
		IsOnFare[playerid] = 0;
		KillTimer(faretimer[playerid]);
	 	return 1;
	}
	return 1;
	
}
CMD:spawntaxi(playerid,params[])
{
	#if defined AllowTaxiSpawn
	new Float:x,Float:y,Float:z;
 	GetPlayerPos(playerid,x,y,z);
 	CreateVehicle(420,x,y,z,0,0,0,10000);
	return 1;
 	#else
 	return SendClientMessage(playerid,COLOR_RED,"Este comando está desactivado");
	#endif
 	
}
CMD:servicio(playerid,params[])
{
	
	if(IsOnFare[playerid] == 1) return SendClientMessage(playerid,COLOR_LIGHTBLUE,"Usted se encuentra en una tarifa, no puede ir fuera de servicio ahora!");
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_LIGHTBLUE,"Usted tiene que estar en pie para hacer esto!");
	if(OnDuty[playerid] == 0)
	{
	    new formatted[128];
		OnDuty[playerid] = 1;
        CreatePlayerDraws(playerid);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Ahora se encuentra en el servicio!");
		format(formatted,128,"Tarifa: %.2f$",STARTAMOUNT);
		TextDrawSetString(startfare[playerid],formatted);
		TextDrawSetString(taxistatus[playerid],"Estado del taxi: Libre");
		new format100[128];
		format(format100,128,"100 Precio por metro: %.2f$",MONEYPER100);
		TextDrawSetString(taxi100mfare[playerid],format100);
		Clock();
		return 1;
	}

	if(OnDuty[playerid] == 1)
	{
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Ahora esta fuera de servicio");
		OnDuty[playerid] = 0;
		DestroyPlayerDraws(playerid);
		return 1;
	}


	return 1;
}
//
forward Clock();
public Clock()
{
    new hour,minute;
	gettime(hour,minute);
	new string[128];
	if(minute < 10)
	{
		format(string,sizeof(string),"%d : 0%d",hour,minute);
	}
	else
	{
		format(string,sizeof(string),"%d : %d",hour,minute);
	}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(OnDuty[i] == 1)
			{
				TextDrawSetString(taxitimedisplay[i],string);
			}
		}
	}
	KillTimer(clockupdate);
	clockupdate = SetTimer("Clock",60000,0);
}
forward IsATaxi(vehicleid);
public IsATaxi(vehicleid)
{
	new vmodel = GetVehicleModel(vehicleid);
	if(vmodel == 420 || vmodel == 438)
	{
		return 1;
	}
	return 0;
}

forward DestroyPlayerDraws(playerid);
public DestroyPlayerDraws(playerid)
{
    	TextDrawDestroy(taxiblackbox[playerid]);
		TextDrawDestroy(taxigreendisplay[playerid]);
		TextDrawDestroy(taxitimedisplay[playerid]);
		TextDrawDestroy(taxi100mfare[playerid]);
		TextDrawDestroy(taxithisfare[playerid]);
		TextDrawDestroy(taxilstlogo[playerid]);
		TextDrawDestroy(taxistatus[playerid]);
		TextDrawDestroy(startfare[playerid]);
 		TextDrawDestroy(drivername[playerid]);
	
}
forward CreatePlayerDraws(playerid);
public CreatePlayerDraws(playerid)
{
	#if DESIGN_NUMBER == 1

		taxiblackbox[playerid] = TextDrawCreate(497.000000, 302.000000, "              ");
		TextDrawBackgroundColor(taxiblackbox[playerid], 255);
		TextDrawFont(taxiblackbox[playerid], 1);
		TextDrawLetterSize(taxiblackbox[playerid], 0.500000, 1.000000);
		TextDrawColor(taxiblackbox[playerid], -1);
		TextDrawSetOutline(taxiblackbox[playerid], 0);
		TextDrawSetProportional(taxiblackbox[playerid], 1);
		TextDrawSetShadow(taxiblackbox[playerid], 1);
		TextDrawUseBox(taxiblackbox[playerid], 1);
		TextDrawBoxColor(taxiblackbox[playerid], 255);
		TextDrawTextSize(taxiblackbox[playerid], 140.000000, -1.000000);

		taxigreendisplay[playerid] = TextDrawCreate(484.000000, 318.000000, "          ");
		TextDrawBackgroundColor(taxigreendisplay[playerid], 255);
		TextDrawFont(taxigreendisplay[playerid], 1);
		TextDrawLetterSize(taxigreendisplay[playerid], 0.500000, 1.000000);
		TextDrawColor(taxigreendisplay[playerid], -1);
		TextDrawSetOutline(taxigreendisplay[playerid], 0);
		TextDrawSetProportional(taxigreendisplay[playerid], 1);
		TextDrawSetShadow(taxigreendisplay[playerid], 1);
		TextDrawUseBox(taxigreendisplay[playerid], 1);
		TextDrawBoxColor(taxigreendisplay[playerid], 576786175);
		TextDrawTextSize(taxigreendisplay[playerid], 154.000000, -1.000000);

		taxitimedisplay[playerid] = TextDrawCreate(160.000000, 340.000000, "Hora:  Cargando..");
		TextDrawBackgroundColor(taxitimedisplay[playerid], 255);
		TextDrawFont(taxitimedisplay[playerid], 2);
		TextDrawLetterSize(taxitimedisplay[playerid], 0.250000, 0.799999);
		TextDrawColor(taxitimedisplay[playerid], 835715327);
		TextDrawSetOutline(taxitimedisplay[playerid], 1);
		TextDrawSetProportional(taxitimedisplay[playerid], 1);
	
		taxi100mfare[playerid] = TextDrawCreate(160.000000, 360.000000, format100);
		TextDrawBackgroundColor(taxi100mfare[playerid], 255);
		TextDrawFont(taxi100mfare[playerid], 2);
		TextDrawLetterSize(taxi100mfare[playerid], 0.250000, 0.799999);
		TextDrawColor(taxi100mfare[playerid], 835715327);
		TextDrawSetOutline(taxi100mfare[playerid], 1);
		TextDrawSetProportional(taxi100mfare[playerid], 1);

		taxithisfare[playerid] = TextDrawCreate(160.000000, 380.000000, "Esta Tarifa: N/A ");
		TextDrawBackgroundColor(taxithisfare[playerid], 255);
		TextDrawFont(taxithisfare[playerid], 2);
		TextDrawLetterSize(taxithisfare[playerid], 0.250000, 0.799999);
		TextDrawColor(taxithisfare[playerid], 835715327);
		TextDrawSetOutline(taxithisfare[playerid], 1);
		TextDrawSetProportional(taxithisfare[playerid], 1);

		taxilstlogo[playerid] = TextDrawCreate(220.000000, 317.000000, "Los Santos Transport");
		TextDrawBackgroundColor(taxilstlogo[playerid], 255);
		TextDrawFont(taxilstlogo[playerid], 3);
		TextDrawLetterSize(taxilstlogo[playerid], 0.550000, 1.799998);
		TextDrawColor(taxilstlogo[playerid], 835715327);
		TextDrawSetOutline(taxilstlogo[playerid], 1);
		TextDrawSetProportional(taxilstlogo[playerid], 1);

		taxistatus[playerid] = TextDrawCreate(320.000000, 390.000000, "Estado de taxi: ");
		TextDrawBackgroundColor(taxistatus[playerid], 255);
		TextDrawFont(taxistatus[playerid], 2);
		TextDrawLetterSize(taxistatus[playerid], 0.250000, 0.799998);
		TextDrawColor(taxistatus[playerid], 835715327);
		TextDrawSetOutline(taxistatus[playerid], 1);
		TextDrawSetProportional(taxistatus[playerid], 1);
		
		startfare[playerid] = TextDrawCreate(380.000000, 340.000000, "999");
		TextDrawBackgroundColor(startfare[playerid], 255);
		TextDrawFont(startfare[playerid], 2);
		TextDrawLetterSize(startfare[playerid], 0.250000, 0.799998);
		TextDrawColor(startfare[playerid], 835715327);
		TextDrawSetOutline(startfare[playerid], 1);
		TextDrawSetProportional(startfare[playerid], 1);
		
	#endif
	
	#if DESIGN_NUMBER == 2

	    
	    ClockBase = TextDrawCreate(545.500, 274.000, "LD_POOL:ball");
	    TextDrawFont(ClockBase, 4);
	    TextDrawTextSize(ClockBase, 61.000, 50.500);
	    TextDrawColor(ClockBase, 1296911871);

	    ClockScreen = TextDrawCreate(551.500, 292.000, "LD_DRV:tvbase");
	    TextDrawFont(ClockScreen, 4);
	    TextDrawTextSize(ClockScreen, 49.000, 14.500);
	    TextDrawColor(ClockScreen, 255);

	    BackLight = TextDrawCreate(527.500, 323.500, "LD_NONE:thrust");
	    TextDrawFont(BackLight, 4);
	    TextDrawTextSize(BackLight, 100.000, 100.000);
	    TextDrawColor(BackLight, -327425);

	    taxigreendisplay[playerid] = TextDrawCreate(638.000000, 323.937500, "usebox");
		TextDrawLetterSize(taxigreendisplay[playerid], 0.000000, 8.725000);
		TextDrawTextSize(taxigreendisplay[playerid], 512.000000, 0.000000);
		TextDrawAlignment(taxigreendisplay[playerid], 1);
		TextDrawColor(taxigreendisplay[playerid], 0);
		TextDrawUseBox(taxigreendisplay[playerid], true);
		TextDrawBoxColor(taxigreendisplay[playerid], 8388863);
		TextDrawSetShadow(taxigreendisplay[playerid], 0);
		TextDrawSetOutline(taxigreendisplay[playerid], 0);
		TextDrawFont(taxigreendisplay[playerid], 0);

		taxiblackbox[playerid] = TextDrawCreate(637.000000, 323.937500, "usebox");
		TextDrawLetterSize(taxiblackbox[playerid], 0.000000, 8.773611);
		TextDrawTextSize(taxiblackbox[playerid], 512.500000, 0.000000);
		TextDrawAlignment(taxiblackbox[playerid], 1);
		TextDrawColor(taxiblackbox[playerid], -256);
		TextDrawUseBox(taxiblackbox[playerid], true);
		TextDrawBoxColor(taxiblackbox[playerid], 200);
		TextDrawSetShadow(taxiblackbox[playerid], 0);
		TextDrawSetOutline(taxiblackbox[playerid], 0);
		TextDrawBackgroundColor(taxiblackbox[playerid], -206);
		TextDrawFont(taxiblackbox[playerid], 0);

		taxithisfare[playerid] = TextDrawCreate(524.500000, 330.750000, "Total tarifa: 0 $");
		TextDrawLetterSize(taxithisfare[playerid], 0.211998, 1.018123);
		TextDrawAlignment(taxithisfare[playerid], 1);
		TextDrawColor(taxithisfare[playerid], -1);
		TextDrawSetShadow(taxithisfare[playerid], 0);
		TextDrawSetOutline(taxithisfare[playerid], 1);
		TextDrawBackgroundColor(taxithisfare[playerid], 51);
		TextDrawFont(taxithisfare[playerid], 1);
		TextDrawSetProportional(taxithisfare[playerid], 1);

		startfare[playerid] = TextDrawCreate(525.000000, 339.187500, "Tarifa: 0 $");
		TextDrawLetterSize(startfare[playerid], 0.211998, 1.018123);
		TextDrawAlignment(startfare[playerid], 1);
		TextDrawColor(startfare[playerid], -1);
		TextDrawSetShadow(startfare[playerid], 0);
		TextDrawSetOutline(startfare[playerid], 1);
		TextDrawBackgroundColor(startfare[playerid], 51);
		TextDrawFont(startfare[playerid], 1);
		TextDrawSetProportional(startfare[playerid], 1);

		taxistatus[playerid] = TextDrawCreate(525.000000, 348.500000, "Estado del Taxi: Desocupado");
		TextDrawLetterSize(taxistatus[playerid], 0.211998, 1.018123);
		TextDrawAlignment(taxistatus[playerid], 1);
		TextDrawColor(taxistatus[playerid], -1);
		TextDrawSetShadow(taxistatus[playerid], 0);
		TextDrawSetOutline(taxistatus[playerid], 1);
		TextDrawBackgroundColor(taxistatus[playerid], 51);
		TextDrawFont(taxistatus[playerid], 1);
		TextDrawSetProportional(taxistatus[playerid], 1);

		taxitimedisplay[playerid] = TextDrawCreate(562.000000, 291.375000, "99:99");
		TextDrawLetterSize(taxitimedisplay[playerid], 0.210499, 1.441874);
		TextDrawTextSize(taxitimedisplay[playerid], 598.500000, 39.375000);
		TextDrawAlignment(taxitimedisplay[playerid], 1);
		TextDrawColor(taxitimedisplay[playerid], -1);
		TextDrawSetShadow(taxitimedisplay[playerid], 0);
		TextDrawSetOutline(taxitimedisplay[playerid], 1);
		TextDrawBackgroundColor(taxitimedisplay[playerid], 51);
		TextDrawFont(taxitimedisplay[playerid], 2);
		TextDrawSetProportional(taxitimedisplay[playerid], 1);

		taxi100mfare[playerid] = TextDrawCreate(525.000000, 357.375000, "Tarifa por 100M: 999$");
		TextDrawLetterSize(taxi100mfare[playerid], 0.206496, 1.004997);
		TextDrawAlignment(taxi100mfare[playerid], 1);
		TextDrawColor(taxi100mfare[playerid], -1);
		TextDrawSetShadow(taxi100mfare[playerid], 0);
		TextDrawSetOutline(taxi100mfare[playerid], 1);
		TextDrawBackgroundColor(taxi100mfare[playerid], 51);
		TextDrawFont(taxi100mfare[playerid], 1);
		TextDrawSetProportional(taxi100mfare[playerid], 1);
		
		drivername[playerid] = TextDrawCreate(559.500000, 383.750000, "Nombre de pila");
		TextDrawLetterSize(drivername[playerid], 0.282997, 1.328747);
		TextDrawAlignment(drivername[playerid], 1);
		TextDrawColor(drivername[playerid], -1);
		TextDrawSetShadow(drivername[playerid], 0);
		TextDrawSetOutline(drivername[playerid], 1);
		TextDrawBackgroundColor(drivername[playerid], 51);
		TextDrawFont(drivername[playerid], 1);
		TextDrawSetProportional(drivername[playerid], 1);
		
		yourdriver[playerid] = TextDrawCreate(548.000000, 371.375000, "Su conductor");
		TextDrawLetterSize(yourdriver[playerid], 0.282997, 1.328747);
		TextDrawAlignment(yourdriver[playerid], 1);
		TextDrawColor(yourdriver[playerid], -1);
		TextDrawSetShadow(yourdriver[playerid], 0);
		TextDrawSetOutline(yourdriver[playerid], 1);
		TextDrawBackgroundColor(yourdriver[playerid], 51);
		TextDrawFont(yourdriver[playerid], 1);
		TextDrawSetProportional(yourdriver[playerid], 1);
		
		
	    
	#endif

}
forward CheckDesign();
public CheckDesign()
{
	#if DESIGN_NUMBER == 2
    	ScreenCorner1 = TextDrawCreate(637.000, 322.000, "LD_DUAL:tvcorn");
	    TextDrawFont(ScreenCorner1, 4);
	    TextDrawTextSize(ScreenCorner1, -62.000, 41.500);
	    TextDrawColor(ScreenCorner1, -1);

	    ScreenCorner2 = TextDrawCreate(637.000, 404.500, "LD_NONE:tvcorn");
	    TextDrawFont(ScreenCorner2, 4);
	    TextDrawTextSize(ScreenCorner2, -62.000, -41.000);
	    TextDrawColor(ScreenCorner2, -1);

	    ScreenCorner3 = TextDrawCreate(514.000, 322.000, "LD_DRV:tvcorn");
	    TextDrawFont(ScreenCorner3, 4);
	    TextDrawTextSize(ScreenCorner3, 61.000, 40.000);
	    TextDrawColor(ScreenCorner3, -1);

	    ScreenCorner4 = TextDrawCreate(514.000, 404.500, "LD_DRV:tvcorn");
	    TextDrawFont(ScreenCorner4, 4);
	    TextDrawTextSize(ScreenCorner4, 61.000, -42.500);
	    TextDrawColor(ScreenCorner4, -1);
	#endif
}
forward FareUpdate(playerid);
public FareUpdate(playerid)
{

	
	new farestring[128];
	GetPlayerPos(playerid,NewX[playerid],NewY[playerid],NewZ[playerid]);
	new Float:totdistance = GetDistanceBetweenPoints(OldX[playerid],OldY[playerid],OldZ[playerid], NewX[playerid],NewY[playerid],NewZ[playerid]);
    if(totdistance > 100.0)
    {
	    TotalFare[playerid] = TotalFare[playerid]+MONEYPER100;
		format(farestring,sizeof(farestring),"Total Fare: %.2f $",TotalFare[playerid]);
		TextDrawSetString(taxithisfare[playerid],farestring);
		GetPlayerPos(playerid,Float:OldX[playerid],Float:OldY[playerid],Float:OldZ[playerid]);
	}


	return 1;

}
forward Float:GetDistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2);
stock Float:GetDistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
    x1 -= x2;
    y1 -= y2;
    z1 -= z2;
    return floatsqroot((x1 * x1) + (y1 * y1) + (z1 * z1));
}
stock CheckPassengers(vehicleid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerInAnyVehicle(i))
		{
			if(GetPlayerVehicleID(i) == vehicleid && i != GetVehicleDriver(vehicleid))
			{

				return 1;

			}
		}
	}
	return 0;
}
stock GetNumOfPassengers(driver)
{
	new count = 0;
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerInAnyVehicle(i))
		{
			if(GetPlayerVehicleID(i) == GetPlayerVehicleID(driver) && i != driver)
			{
				count++;
			}
		}
	}
	return count;
}
stock GetFirstName(playerid)
{
    new ns[2][MAX_PLAYER_NAME], n[MAX_PLAYER_NAME];

    GetPlayerName(playerid,n,MAX_PLAYER_NAME);
    split(n, ns, '_');
    return ns[0];
}
stock GetPlayerNameEx(playerid)
{
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pname,sizeof(pname));
	return pname;
}
stock split(const strsrc[], strdest[][], delimiter)
{
    new i, li;
    new aNum;
    new len;
    while(i <= strlen(strsrc))
    {
        if(strsrc[i] == delimiter || i == strlen(strsrc))
        {
            len = strmid(strdest[aNum], strsrc, li, i, 128);
            strdest[aNum][len] = 0;
            li = i+1;
            aNum++;
        }
        i++;
    }
    return 1;
}
