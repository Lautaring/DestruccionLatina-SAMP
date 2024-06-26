/*
	Name: Anti-Proxy
	File (default): ProxyDetector.inc
	Version: 2.0
	Author: Gnikllort
	Rewritten by: Xeon

	Functions:

		- bool:IsPlayerUsingProxy(playerid)
		- ProxyDetectKick(bool:toggle)

	Callback:

		- OnPlayerProxyCheck(playerid, playerip[], bool:proxy)
*/

#if defined _included_proxydetector
    #endinput
#endif

#define _included_proxydetector

#include <a_http> 

static 
	
	ProxyAutoKick = false,
	bool:IsUsingProxy[MAX_PLAYERS char] = {false, ...}
;

stock IsPlayerUsingProxy(playerid) return IsUsingProxy{playerid};

public OnGameModeInit()
{
	print("*Anti Proxy v2.0 by Gnikllort, Rewritten by Xeon Loaded.");
	
    #if defined HTTP_OnGameModeInit
         return HTTP_OnGameModeInit();
    #else
   	 	return 1;
	#endif

}
#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit HTTP_OnGameModeInit
#if defined HTTP_OnGameModeInit
    forward HTTP_OnGameModeInit();
#endif

public OnPlayerConnect(playerid)
{
	IsUsingProxy{playerid} = false;

	new ip[62];
	GetPlayerIp(playerid, ip, sizeof(ip));
	if(strcmp(ip, "127.0.0.1", true) == 0) return 1;

	format(ip, sizeof(ip), "proxy.mind-media.com/block/proxycheck.php?ip=%s", ip);
	HTTP(playerid, HTTP_GET, ip, "", "HTTP_OnPlayerProxyCheck");

    #if defined HTTP_OnPlayerConnect
         return HTTP_OnPlayerConnect(playerid);
    #else
   	 	return 1;
	#endif

}
#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect HTTP_OnPlayerConnect
#if defined HTTP_OnPlayerConnect
    forward HTTP_OnPlayerConnect(playerid);
#endif

forward HTTP_OnPlayerProxyCheck(playerid, response_code, data[]);
public HTTP_OnPlayerProxyCheck(playerid, response_code, data[])
{
	if(response_code == 200)
	{	
		switch(data[0])
		{
			case 'Y': return CallRemoteFunction("OnPlayerProxyCheck", "ii", playerid, true);
			case 'N': return CallRemoteFunction("OnPlayerProxyCheck", "ii", playerid, false);
			case 'X': return printf("(Proxy Detector): invalid ip format.");
			default: return printf("The request failed! The response code was: %d", response_code);
		}
	}
	return 1;
}

forward OnPlayerProxyCheck(playerid, bool:proxy);
public OnPlayerProxyCheck(playerid, bool:proxy)
{
	if(proxy)
	{
		IsUsingProxy{playerid} = true;
		if(ProxyAutoKick)
		{
			new string[89];
			GetPlayerName(playerid, string, sizeof(string));
			format(string, sizeof(string), "[Proxy Detector]: %s (%d) has been kicked for using a vpn/proxy.", string, playerid);
			SendClientMessageToAll(0xFF0000FF, string);
			SetTimerEx("HTTP_DelayedKick", 1000, false, "i", playerid);
		}
	}
	return 1;
}

forward HTTP_DelayedKick(playerid);
public HTTP_DelayedKick(playerid)
{
	Kick(playerid);
	return 1;
}

stock ProxyDetectKick(bool:toggle)
{
	if(toggle == ProxyAutoKick) return 1;
	ProxyAutoKick = toggle;
	printf("(Proxy Detector): Proxy auto kick has been toggled %s.", ((toggle) ? ("on") : ("off")));
	return 1;
}