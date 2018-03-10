
/*	Copyright (C) 2018 IT-KiLLER
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

#include <sourcemod>
#include <sdktools>
#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo =
{
	name = "[CS:GO/CS:S] Permanently disable bots",
	author = "IT-KiLLER",
	description = "",
	version = "1.0",
	url = "https://github.com/IT-KiLLER"
};

public void OnAllPluginsLoaded()
{
	RegServerCmd("nav_generate", BlockCommand);
	LOCKED("bot_quota", 0.0);
	LOCKED("bot_join_delay", 99999.0);
	LOCKED("bot_join_after_player", 1.0);
}

public void OnPluginEnd()
{
	RESTORE("bot_quota", 64.0);
	RESTORE("bot_join_delay", 99999.0);
	RESTORE("bot_join_after_player", 1.0);
}

public Action BlockCommand(int args)
{
	PrintToServer("[SM] bots permanently disabled by plugin.");
	return Plugin_Handled;
}

stock void LOCKED(const char[] strCvar, float value = 1.0)
{
	ConVar cvar = FindConVar(strCvar);
	if(!cvar) return;
	cvar.SetFloat(value, false, false);
	cvar.SetBounds(ConVarBound_Upper, true, value);
	cvar.SetBounds(ConVarBound_Lower, true, value);
}

stock void RESTORE(const char[] strCvar, float max = 1.0, float min = 0.0)
{
	ConVar cvar = FindConVar(strCvar);
	if(!cvar) return;
	cvar.SetBounds(ConVarBound_Upper, true, max);
	cvar.SetBounds(ConVarBound_Lower, true, min);
	cvar.RestoreDefault(false, false);
}