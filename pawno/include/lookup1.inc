//===[Misc]=====================================================================

#include <a_http>
#include <a_json>

#define GetPlayerHost(%1) LookupData[%1][Hostname]
#define GetPlayerISP(%1) LookupData[%1][ISP]
#define GetPlayerCountryCode(%1) LookupData[%1][Code]
#define GetPlayerCountryName(%1) LookupData[%1][Country]
#define GetPlayerCountryRegion(%1) LookupData[%1][Region]
#define IsProxyUser(%1) LookupData[%1][Proxy]

enum ldata
{
	Hostname[60],
	ISP[60],
	Code[3],
	Country[45],
	Region[43],
	Proxy
};

new
	LookupData[MAX_PLAYERS][ldata],
	PlayerSession[MAX_PLAYERS],
	Retry[MAX_PLAYERS];

forward OnLookupResponse(sessionid, response, data[]);
forward OnLookupComplete(playerid);

//===[Callbacks]================================================================

public OnPlayerConnect(playerid)
{
	cleardata(LookupData[playerid][Hostname]);
	cleardata(LookupData[playerid][ISP]);
	cleardata(LookupData[playerid][Code]);
	cleardata(LookupData[playerid][Country]);
	cleardata(LookupData[playerid][Region]);
	LookupData[playerid][Proxy] = 0;

	Retry[playerid] = 0;
	PlayerSession[playerid] = 0;
	LookupPlayerIP(playerid);

	return CallLocalFunction("Lookup_OnPlayerConnect", "i", playerid);
}

public OnLookupResponse(sessionid, response, data[])
{
	new hostname[128], isp[128], code[128], country[128], region[128], proxy[128];
	new playerid = GetPlayerFromSession(sessionid);

	if(playerid == -1) return 1;

	if(response != 200)
	{
		if(Retry[playerid] == 0)
		{
			Retry[playerid] = 1;
			LookupPlayerIP(playerid);
		}
		return 1;
	}

	new JSONNode:dataNode = json_parse_string(data);

    json_get_string(dataNode, hostname, sizeof(hostname), "ipName");
    json_get_string(dataNode, isp, sizeof(isp), "isp");
    json_get_string(dataNode, code, sizeof(code), "countryCode");
    json_get_string(dataNode, country, sizeof(country), "country");
    json_get_string(dataNode, region, sizeof(region), "region");
    json_get_string(dataNode, proxy, sizeof(proxy), "query");
	
	format(LookupData[playerid][Hostname], 60, hostname);
	format(LookupData[playerid][ISP], 60, isp);
	format(LookupData[playerid][Code], 60, code);
	format(LookupData[playerid][Country], 60, country);
	format(LookupData[playerid][Region], 60, region);
    format(LookupData[playerid][Proxy], 60, proxy);

    json_close(dataNode);
	CallLocalFunction("OnLookupComplete", "i", playerid);

	return 1;
}

//===[Functions]================================================================

stock LookupPlayerIP(playerid)
{
	if(!IsPlayerNPC(playerid))
	{

	new ip[16], lQuery[60];

	static
	SessionIndex;
	SessionIndex++;
	PlayerSession[playerid] = SessionIndex;

	GetPlayerIp(playerid, ip, sizeof(ip));
	format(lQuery, sizeof(lQuery), "extreme-ip-lookup.com/json/%s", ip);

	HTTP(SessionIndex, HTTP_GET, lQuery, "", "OnLookupResponse");

	}
}

stock GetPlayerFromSession(sessionid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	if(IsPlayerConnected(i) && PlayerSession[i] == sessionid)
	return i;
	}

	return -1;
}

stock DisplayLookupData(playerid, targetid)
{
	/*new lstr[300], boxname[40];

	GetPlayerIp(targetid, boxname, sizeof(boxname));
	format(boxname, sizeof(boxname), "IP Lookup: %s", boxname);

	format(lstr, sizeof(lstr),
	"Hostname: %s\n\
	ISP: %s\n\
	Country: %s (%s)\n\
	State/Region: %s",
	LookupData[targetid][Hostname],
	LookupData[targetid][ISP],
	LookupData[targetid][Country],
	LookupData[targetid][Code],
	LookupData[targetid][Region]);

	ShowPlayerDialog(playerid, 30000, DIALOG_STYLE_MSGBOX, boxname, lstr, "Close", "");*/
}

stock strmidex(dest[], const src[],  start, end, maxlength=sizeof dest)
{
	if(end - start > 1)
	strmid(dest, src,  start, end, maxlength);
}

stock cleardata(src[])
{
    src[0] = '?';
    
	new c = 1;
	while(src[c] != '\0')
	{
		src[c] = '\0';
		c++;
	}
}

//===[Hooking]==================================================================

#if defined _ALS_OnPlayerConnect
#undef OnPlayerConnect
#else
#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect Lookup_OnPlayerConnect

forward Lookup_OnPlayerConnect(playerid);