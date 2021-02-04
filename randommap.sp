#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "randommap",
	author = "rov/sikari",
	description = "Clients type '!randommap', changes the map to a random map",
	version = "1.0.2",
	url = "https://github.com/rov-giga-brain"
};

ArrayList g_Maps = null;

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	RegAdminCmd("sm_randommap", Command_RandomMap, ADMFLAG_CHANGEMAP, "Changes the map to a random map");
}

public void OnPluginStart()
{
	g_Maps = new ArrayList(ByteCountToCells(PLATFORM_MAX_PATH));
	ReadMapList(g_Maps);
}

public Action Command_RandomMap(int client, int args)
{
	int rndIdx = GetRandomInt(0, g_Maps.Length - 1);

	CreateTimer(3.0, Timer_ChangeMap, rndIdx, TIMER_FLAG_NO_MAPCHANGE);
	PrintCenterTextAll("WARNING: Map Change Iminent!");	
    
	return Plugin_Handled;
}

public Action Timer_ChangeMap(Handle timer, int mapIndex)
{
	char map[PLATFORM_MAX_PATH];
	g_Maps.GetString(mapIndex, map, sizeof(map));

	PrintToChatAll("Changing map to '%s'", map);
	
	ForceChangeLevel(map, "Random map change");
}
