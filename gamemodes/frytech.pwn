// FryTech's SAMP Mod - beta
// ----------------------------
// Основные инклюды
#include <a_samp>
#include <colandreas>
#include <sscanf2>
#include <streamer>
#include <Pawn.CMD>
#include <a_mysql>
#include <md5>
#include <Pawn.Regex>
#include <foreach>
#include <fix>
#include <airbreak>

#pragma warning disable 203
#pragma warning disable 209
#pragma warning disable 213
#pragma warning disable 214
#pragma warning disable 235
#pragma warning disable 239

// Серверные методы

// Мои инклюды
#include <fry_lang>
#include <fry_useful>
#include <fry_config>
#include <fry_textdraws>
#include <fry_objects>
#include <fry_date>

// Конфигурация MySQL
#define MYSQL_HOST "localhost"
#define MYSQL_USER "root"
#define MYSQL_PASS "alisasom5677"
#define MYSQL_DB "frysamp"

new MySQL:DBHandle;

// Конфигурация сервера
#undef MAX_PLAYERS
#define MAX_PLAYERS 1000

new SHour, SMinute, SSecond; // Время сервера

// Массив игрок->параметры
enum _PDATA
{
	ID, NAME[24],
	PASSWORD[32 + 1], MAIL[MAX_MAIL],
	REGIP[16], LASTIP[16],
	STATUS, DONATE,
	ADMIN,
	MUTE_TIME, WARNS, LAST_WARN_TIME, DEMORGAN,
	TIMEPLAYED,
	LVL, EXP,
	CASH, BANK, DEPOSIT,
	PHONE,
	SEX, RACE, SKIN,
	SPAWN,
	DIED,
	Float:HP, Float:ARM,
	JOB,
	MEMBER, RANK, FMUTE_TIME, FWARNS,
	LAW_ABIDING, WARNING_LVL, JAIL_TIME, JAIL_TIMES,
	REFERAL[24],
	// ...
}

enum _PTHINGS
{
	PHONE,
	BANK_CARD
	// ...
}

enum _PINFO
{
	AUTH_LIMIT,
	EXIT_DIALOG,
	Boolean:LOGGED, // Залогинился ли игрок?
	TIMER[2], // Таймеры игрока
	Float:LAST_COORDS[5], // Последние координаты (x, y, z, int, VW)
	AFK, // АФК игрока
	TEXTDRAW_ID, // TextDraw, который игрок видит сейчас (нужно для проверки)
	LAST_DLG_INFO[4] // Данные последнего диалога (защита от DLG Hider)
	// ...
}

enum _AINFO
{
	TO_UNBANIP[16], TO_UNBAN[24],
	SPECTATING
	// ...
}

new player[MAX_PLAYERS][_PDATA]; // Параметры игрока
#define PLAYER player[playerid]
#define TARGET player[target]
#define I player[i]

new thing[MAX_PLAYERS][_PTHINGS]; // Предметы игрока
#define PTHING thing[playerid]
#define TTHING thing[target]
#define ITHING thing[i]

new pinfo[MAX_PLAYERS][_PINFO]; // Остальная инфа по игроку
#define PINFO pinfo[playerid]
#define TINFO pinfo[target]
#define IINFO pinfo[i]

new ainfo[MAX_PLAYERS][_AINFO]; // Инфа по админу
#define AINFO ainfo[playerid]

// Диалоги
enum _DLG
{
	DLG_NONE,
	DLG_REG, DLG_REG_SEX, DLG_REG_RACE, DLG_REG_REFERAL,
	DLG_LOGIN,
	DLG_MENU01, DLG_MENU02, DLG_MENU03,
	DLG_NONRP_NAME,
	DLG_STATS01, DLG_STATS02,
	DLG_KICK,
	DLG_BANIP, DLG_UNBANIP, DLG_BANNEDIP,
	DLG_BAN, DLG_UNBAN, DLG_BANNED
	// ...
}

stock ShowPlayerDialogEx(playerid, dialogid, style, caption[], info[], button1[], button2[])
{
	ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	PINFO[LAST_DLG_INFO][0] = gettime();
	PINFO[LAST_DLG_INFO][1] = floatround(x);
	PINFO[LAST_DLG_INFO][2] = floatround(y);
	PINFO[LAST_DLG_INFO][3] = floatround(z);
}

stock IsDialogValid(playerid, dialogid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	switch (dialogid)
	{
		case 1..5: if (!PINFO[LOGGED]) return 1; else return 0;
		default: if ((PINFO[LAST_DLG_INFO][0] == gettime()) || (PINFO[LAST_DLG_INFO][1] == floatround(x) && PINFO[LAST_DLG_INFO][2] == floatround(y) && PINFO[LAST_DLG_INFO][3] == floatround(z)))
		return 1; else return 0;
	}
}

main()
{
	print("Мод by FryTech v1.0");
}

public OnGameModeInit()
{
	MySQLConnect();

	SetTimer("@_ServerTimer", 1000, true);
	gettime(SHour, SMinute, SSecond);

	printf("Устанавливаем серверный таймер... [#1]");
	printf("Текущее время на сервере: %02d:%02d:%02d", SHour, SMinute, SSecond);

	printf("Инициализируем TextDraws... [OK]");
	InitializeTextDraws();

	DisableInteriorEnterExits(); // Убрать дефолтные пикапы

	/* printf("Инициализируем Objects... [OK]");
	InitializeObjects();

	printf("Инициализируем Vehicles... [OK]");
	InitializeObjects();

	printf("Инициализируем Actors... [OK]");
	InitializeActors(); */

	printf("Загружаем языковой файл... [OK]");

	printf("Устанавливаем алиасы для команд... [ОК]");
	PC_RegAlias("stats", "statistics");
	PC_RegAlias("menu", "mn", "mm");
	PC_RegAlias("spawn", "spawnplayer");
	PC_RegAlias("givemoney", "addmoney");
	PC_RegAlias("re", "spectate");
	PC_RegAlias("reoff", "specoff");
	PC_RegAlias("n", "b");

	printf(date(1767200437, GMT));
	return 1;
}

public OnGameModeExit()
{
	foreach (new i : Player) if (IINFO[LOGGED]) SaveAccount(i);

	DestroyTextDraws();

	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if (PINFO[LOGGED]) return SetSpawnInfo(playerid, 0, PLAYER[SKIN], 0, 0, 0, 0), SpawnPlayer(playerid);
	return 1;
}

public OnPlayerConnect(playerid)
{
	RemoveBuildingsForPlayer(playerid);

	TogglePlayerControllable(playerid, 0);
	TogglePlayerSpectating(playerid, 1);
	InterpolateCameraPos(playerid, 1280.6528, -2037.6846, 80.6408, 13.4005, -2087.5444, 35.9909, 25000);
	InterpolateCameraLookAt(playerid, 446.5704, -2036.8873, 30.9909, 367.5072, -1855.4072, 11.2948, 25000);

	SCMInfo(playerid, SERVER_GREETING);
	DefaultPlayerData(playerid);
	PINFO[TIMER][0] = SetTimerEx("@_SecondUpdate", 1000, true, "i", playerid);
	Connection(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	PINFO[LOGGED] = false;
	KillTimer(PINFO[TIMER][0]);
	KillTimer(PINFO[TIMER][1]);

	if (PLAYER[ADMIN] > 0)
	{
		AINFO[TO_UNBANIP] = EOS;
		AINFO[TO_UNBAN] = EOS;
		AINFO[SPECTATING] = -1;
	}

	SaveAccount(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if (PINFO[LOGGED])
	{
		if (AINFO[SPECTATING] != -1)
		{
			SetPlayerInterior(playerid, PINFO[LAST_COORDS][3]);
			SetPlayerVirtualWorld(playerid, PINFO[LAST_COORDS][4]);
			SetPlayerPos(playerid, PINFO[LAST_COORDS][0], PINFO[LAST_COORDS][1], PINFO[LAST_COORDS][2]);

			PINFO[LAST_COORDS][0] = -1; PINFO[LAST_COORDS][1] = -1; PINFO[LAST_COORDS][2] = -1; PINFO[LAST_COORDS][3] = -1; PINFO[LAST_COORDS][4] = -1;

			AINFO[SPECTATING] = -1;
		}
		else
		{
			SpawnPlayerEx(playerid);
			if (PLAYER[DIED] == 1) // Изменить, когда введу больницу
			{
				PLAYER[DIED] = 0;
				PLAYER[HP] = 15;
			}
			SetPlayerHealth(playerid, PLAYER[HP]);
			AC_SetPlayerCash(playerid, PLAYER[CASH]);
		}
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	PLAYER[DIED] = 1;
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

public OnPlayerText(playerid, text[])
{
	if (PINFO[LOGGED])
	{
		new Boolean:emoted;

		if (!strcmp(text, ")", true) || !strcmp(text, ":)", true)) PC_EmulateCommand(playerid, "/me улыбается"), emoted = true;
		if (!strcmp(text, "))", true)) PC_EmulateCommand(playerid, "/me смеется"), emoted = true;
		if (!strcmp(text, "(", true)) PC_EmulateCommand(playerid, "/me грустит"), emoted = true;
		if (!strcmp(text, "((", true)) PC_EmulateCommand(playerid, "/me очень расстроился"), emoted = true;
		if (!strcmp(text, "xD", true)) PC_EmulateCommand(playerid, "/me валяется от смеха"), emoted = true;
		if (!strcmp(text, ":D", true)) PC_EmulateCommand(playerid, "/me хохочет во весь голос"), emoted = true;
		if (!strcmp(text, ";)", true)) PC_EmulateCommand(playerid, "/me подмигивает"), emoted = true;
		if (!strcmp(text, "O_O", true)) PC_EmulateCommand(playerid, "/me очень удивился"), emoted = true;
		if (!strcmp(text, ">_<", true)) PC_EmulateCommand(playerid, "/me сморщился от злости"), emoted = true;

		if (!RegexCheck(text, "^[ \t\n]*$") && !(strlen(text) > MAX_CHAT_MSG) && !emoted)
		{
			new msg[MAX_CHAT_STR];
			format(msg, sizeof(msg), PLAYER_CHAT_MSG, PLAYER[NAME], playerid, text);
			LocalChat(playerid, msg, X_COLOUR_WHITE);
			SetPlayerChatBubble(playerid, text, X_COLOUR_WHITE, CHATBUBBLE_RADIUS, 1000 * 5);
			if (GetPlayerState(playerid == PLAYER_STATE_ONFOOT))
			{
				ApplyAnimation(playerid, "PED", "IDLE_chat", 4.1, 0, 1, 1, 1, 1);
				new duration = strlen(text)*150;
				SetTimerEx("@_StopAnim", duration, false, "i", playerid);
			}
		}
		else if (strlen(text) > MAX_CHAT_MSG) SCM(playerid, X_COLOUR_GREY, BIG_TEXT_MSG);
	}
	return 0;
}

@_StopAnim(playerid)
{
	ApplyAnimation(playerid, "PED", "facanger", 4.1, 0, 1, 1, 1, 1);
	return 1;
}

stock LocalChat(playerid, msg[], colour = -1, Float:radius = CHAT_RADIUS)
{
	new virtualworld = GetPlayerVirtualWorld(playerid);
	new interior = GetPlayerInterior(playerid);

	new Float:x, Float:y, Float:z, Float:dist;
	GetPlayerPos(playerid, x, y, z);

	foreach(new i : Player)
	{
		if(!PINFO[LOGGED] || IsPlayerNPC(i) || virtualworld != GetPlayerVirtualWorld(i) || interior != GetPlayerInterior(i)) continue;
		dist = GetPlayerDistanceFromPoint(i, x, y, z);
		if(dist < radius) SCM(i, colour, msg);
	}

	return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
	if (PINFO[LOGGED])
	{
		if(result == -1)
		{
				SCMError(playerid, UNKNOWN_CMD_MSG);
				return 0;
		}
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	foreach (new i : Player)
	{
		if (I[LOGGED])
		{
			if (I[ADMIN] > 0)
			{
				if (ainfo[i][SPECTATING] == playerid)
				{
					if (GetPlayerState(playerid) == PLAYER_STATE_WASTED) return GameTextForPlayer(i, "~r~Target is dead!", 5000, 3); // Игрок убит
					if (GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) return GameTextForPlayer(i, "~r~Target is in spectating mode!", 5000, 3); // Игрок перешел в режим слежки
					if (!IsPlayerConnected(playerid)) return GameTextForPlayer(i, "~r~Target has disconnected!", 5000, 3); // Игрок отключился

					SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
					SetPlayerInterior(i, GetPlayerInterior(playerid));

					TogglePlayerSpectating(i, 1);
					if (IsPlayerInAnyVehicle(i)) PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid), SPECTATE_MODE_NORMAL);
					else PlayerSpectatePlayer(i, playerid, SPECTATE_MODE_NORMAL);
				}
			}
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (PINFO[LOGGED])
	{
		if (newkeys == KEY_YES) // Кнопка y/Y - показать курсор
		{
			SelectTextDraw(playerid, X_COLOUR_WHITE);
			SCMInfo(playerid, SHOW_MOUSE_MSG);
		}
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if (PINFO[LOGGED])
	{
		if (PINFO[AFK] >= 10)
		{
			new str[64];
			if (PINFO[AFK] < 60) format(str, sizeof(str), AFK_FINISH_MSG, 0, PINFO[AFK]);
			else
			{
				new minutes = floatround(PINFO[AFK]/60, floatround_floor);
				new seconds = PINFO[AFK] % 60;

				format(str, sizeof(str), AFK_FINISH_MSG, minutes, seconds);
			}
			SCM(playerid, X_COLOUR_GREY, str);
		}
		PINFO[AFK] = 0;
	}
	return 1;
}

@_SecondUpdate(playerid)
{
	if (PINFO[LOGGED])
	{
		AC_Cash(playerid);
		AC_Health(playerid);
		AC_Armour(playerid);

		UpdateAFK(playerid);
	}
	else
	{
		PINFO[AFK]++;
		if (PINFO[AFK] > MAX_AFK_TIME)
		{
			PINFO[AFK] = 0;
			SCMInfo(playerid, DLG_TIME_OVER_MSG);
			ExitServerDialog(playerid);
		}
	}
	return 1;
}

@_MinuteUpdate(playerid)
{
	if (PINFO[LOGGED])
	{
		if (PINFO[AFK] <= MAX_AFK_TIME) PLAYER[TIMEPLAYED]++;
		if (PLAYER[TIMEPLAYED] >= 60) PLAYER[TIMEPLAYED] = 0;
	}
}

@_ServerTimer()
{
	gettime(SHour, SMinute, SSecond);
	if ((SMinute == 0) && (SSecond == 0)) PayDay();
	if ((SMinute % 10 == 0) && (SSecond == 0))
	{
		foreach(new i : Player) if (IINFO[LOGGED]) SaveAccount(i);
		print("Выполнено сохранение аккаунтов! (следующее - через 10 минут)");
	}
}

// Система PayDay
stock PayDay(amount = 1, callerID = -1)
{
	if (callerID == -1) printf("[Уведомление] На сервере выполнен запланированный PayDay (x%d)", amount);
	else printf("[Уведомление] %s[%d] вызвал PayDay (x%d)", player[callerID][NAME], callerID, amount);

	for (new k = 0; k < amount; k++)
	{
		foreach(new i : Player)
		{
			if (IINFO[LOGGED])
			{
				if (I[TIMEPLAYED] >= MIN_PAYDAY_TIME)
				{

					new str[MAX_CHAT_STR];

					SCM(i, X_COLOUR_DOLLAR, PAYDAY_START_MSG);

					if (IsPlayerLevelUp(i)) format(str, sizeof(str), PAYDAY_NEWLVL_MSG, I[LVL]);
					else format(str, sizeof(str), PAYDAY_LVL_MSG, I[LVL]);
					SCM(i, X_COLOUR_WHITE, str);

					format(str, sizeof(str), PAYDAY_EXP_MSG, EXP_PER_PAYDAY, I[EXP], 8 + (2 * (I[LVL] - 1)));
					SCM(i, X_COLOUR_WHITE, str);
					// Еще что-то, зарплата, законопослушность и прочее..
					SCM(i, X_COLOUR_DOLLAR, PAYDAY_FINAL_MSG);

					SetPlayerScore(i, I[LVL]);
					AC_SetPlayerCash(i, I[CASH]);
					I[TIMEPLAYED] = 0;
				}
				else
				{
					new str[80];
					format(str, sizeof(str), PAYDAY_ERROR01_MSG, MIN_PAYDAY_TIME);
					SCMError(i, str);
				}
			}
			else SCMError(i, PAYDAY_ERROR02_MSG);
			SaveAccount(i);
		}
	}
	return 1;
}

stock IsPlayerLevelUp(playerid) // Выполняется в пэйдэй, добавляет очки репутации, повышает лвл, возвращает true/false
{
	if (PLAYER[EXP] + EXP_PER_PAYDAY >= (8 + (2 * (PLAYER[LVL] - 1))))
	{
		PLAYER[EXP] = (PLAYER[EXP] + EXP_PER_PAYDAY) - (8 + (2 * (PLAYER[LVL] - 1)));
		PLAYER[LVL]++;
		return true;
	}
	else
	{
		PLAYER[EXP] += EXP_PER_PAYDAY;
		return false;
	}
}

// Система АФК
stock UpdateAFK(playerid)
{
	PINFO[AFK]++;
	if (PINFO[AFK] > 1)
	{
		new str[64];
		if (PINFO[AFK] < 60) format(str, sizeof(str), AFK_SEC_STR, PINFO[AFK]);
		else if (PINFO[AFK] < MAX_AFK_TIME)
		{
			new minutes = floatround(PINFO[AFK]/60, floatround_floor);
			new seconds = PINFO[AFK] % 60;
			format(str, sizeof(str), AFK_MIN_STR, minutes, seconds);
		}
		else format(str, sizeof(str), AFK_EATING_STR);
		SetPlayerChatBubble(playerid, str, X_COLOUR_WHITE, CHATBUBBLE_RADIUS, 3000); // 3000 - чтобы не ChatBubble не моргал
	}
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	if (player[forplayerid][LOGGED])
	{
		if (player[forplayerid][ADMIN] > 0)
		{
			if (ainfo[forplayerid][SPECTATING] == playerid)
			{
				if (GetPlayerState(playerid) == PLAYER_STATE_WASTED) return GameTextForPlayer(forplayerid, "~r~Target wasted!", 5000, 3); // Игрок убит
				if (GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) return GameTextForPlayer(forplayerid, "~r~Target in spectating mode!", 5000, 3); // Игрок перешел в режим слежки
				if (!IsPlayerConnected(playerid)) return GameTextForPlayer(forplayerid, "~r~Target disconnected!", 5000, 3); // Игрок отключился

				SetPlayerVirtualWorld(forplayerid, GetPlayerVirtualWorld(playerid));
				SetPlayerInterior(forplayerid, GetPlayerInterior(playerid));

				TogglePlayerSpectating(forplayerid, 1);
				if (IsPlayerInAnyVehicle(forplayerid)) PlayerSpectateVehicle(forplayerid, GetPlayerVehicleID(playerid), SPECTATE_MODE_NORMAL);
				else PlayerSpectatePlayer(forplayerid, playerid, SPECTATE_MODE_NORMAL);
			}
		}
	}
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if (IsDialogValid(playerid, dialogid))
	{
		SCM(playerid, X_COLOUR_WHITE, "TRUE");
		switch(dialogid)
		{
			case DLG_REG:
			{
				if (response)
				{
					if (!strlen(inputtext))
					{
						ShowRegDialog(playerid);
						return SCMError(playerid, DLG_REG_EMPTY_MSG);
					}
					else if ((strlen(inputtext) < 8) || (strlen(inputtext) > 32))
					{
						ShowRegDialog(playerid);
						return SCMError(playerid, DLG_REG_NOT_ALLOWED_PASS01_MSG);
					}
					else if (!RegexCheck(inputtext, "^[a-zA-Z0-9]{1,}$"))
					{
						ShowRegDialog(playerid);
						return SCMError(playerid, DLG_REG_NOT_ALLOWED_PASS02_MSG);
					}
					else
					{
						format(PLAYER[PASSWORD], 32 + 1, MD5_Hash(inputtext));
						ShowRegDialog(playerid, 2);
					}
				}
				else
				{
					if (PINFO[EXIT_DIALOG] > 1)
					{
						ShowRegDialog(playerid);
						PINFO[EXIT_DIALOG]--;
					}
					else ExitServerDialog(playerid);
				}
			}
			case DLG_REG_SEX:
			{
				if (response)
				{
					if (listitem == 0) PLAYER[SEX] = 1;
					else PLAYER[SEX] = 2;

					ShowRegDialog(playerid, 3);
				}
				else ShowRegDialog(playerid);
			}
			case DLG_REG_RACE:
			{
				if (response)
				{
					if (listitem == 0) PLAYER[RACE] = 1;
					else if (listitem == 1) PLAYER[RACE] = 2;
					else PLAYER[RACE] = 3;
					ShowRegDialog(playerid, 4);
				}
				else ShowRegDialog(playerid, 1);
			}
			case DLG_REG_REFERAL:
			{
				if (response)
				{
					if (strlen(inputtext) > 0)
					{
						format(PLAYER[REFERAL], 24, inputtext);

						new query[84];
						format(query, sizeof(query), "SELECT `ID` FROM `accounts` WHERE `Nickname` = '%s' LIMIT 1", inputtext);
						mysql_tquery(DBHandle, query, "@_CheckPlayerRegistered", "ii", playerid, 1);
					}
					else
					{
						format(PLAYER[REFERAL], 24, "none");
						OnRegistrationSuccessful(playerid);
					}
				}
				else
				{
					format(PLAYER[REFERAL], 24, "none");
					OnRegistrationSuccessful(playerid);
				}
			}
			case DLG_LOGIN:
			{
				if (response)
				{
					if ((strlen(inputtext) < 8) || (strlen(inputtext) > 32) || !(RegexCheck(inputtext, "^[a-zA-Z0-9]{1,}$"))) // Т.к. такие пароли нет смысла проверять, их не может быть
					{
						if (PINFO[AUTH_LIMIT] > 1)
						{
							PINFO[AUTH_LIMIT]--;
							ShowLoginDialog(playerid, -1);
						}
						else
						{
							SCMError(playerid, DLG_LOGIN_PASSWORD_WRONG_MSG);
							ExitServerDialog(playerid);
						}
					}
					else if (!strcmp(MD5_Hash(inputtext), PLAYER[PASSWORD])) OnPlayerLoginSuccessful(playerid);
					else
					{
						if (PINFO[AUTH_LIMIT] > 1)
						{
							PINFO[AUTH_LIMIT]--;
							ShowLoginDialog(playerid, -1);
						}
						else
						{
							SCM(playerid, -1, DLG_LOGIN_PASSWORD_WRONG_MSG);
							ExitServerDialog(playerid);
						}
					}
				}
				else
				{
					if (PINFO[EXIT_DIALOG] > 1)
					{
						if (PINFO[AUTH_LIMIT] == 3) ShowLoginDialog(playerid);
						else ShowLoginDialog(playerid, -1);
						PINFO[EXIT_DIALOG]--;
					}
					else ExitServerDialog(playerid);
				}
			}
			case DLG_MENU01:
			{
				if (response)
				{
					switch (listitem)
					{
						case 0: // Параметры персонажа
						{
							SPD(playerid, DLG_MENU02, DIALOG_STYLE_LIST, DLG_MENU02_HEADER, DLG_MENU02_LIST, DLG_SELECT, DLG_BACK);
						}
						case 1: // Навыки персонажа
						{
							SPD(playerid, DLG_MENU03, DIALOG_STYLE_LIST, DLG_MENU03_HEADER, DLG_MENU03_LIST, DLG_SELECT, DLG_BACK);
						}
						case 2: PC_EmulateCommand(playerid, "/report");
						case 3: PC_EmulateCommand(playerid, "/settings");
						case 4: PC_EmulateCommand(playerid, "/help");
						case 5: PC_EmulateCommand(playerid, "/donate");
					}
				}
			}
			case DLG_MENU02:
			{
				if (response)
				{
					switch (listitem)
					{
						case 0: PC_EmulateCommand(playerid, "/stats");
						case 1: PC_EmulateCommand(playerid, "/cars");
						case 2: PC_EmulateCommand(playerid, "/house");
						case 3: PC_EmulateCommand(playerid, "/leader");
						case 4: PC_EmulateCommand(playerid, "/fammenu");
						case 5:
						{
							new str[16] = "/showlic %d";
							format(str, sizeof(str), str, playerid);
							PC_EmulateCommand(playerid, str);
						}
						case 6:
						{
							new str[16] = "/showpass %d";
							format(str, sizeof(str), str, playerid);
							PC_EmulateCommand(playerid, str);
						}
						case 7: PC_EmulateCommand(playerid, "/quest");
						case 8: SPD(playerid, DLG_NONRP_NAME, DIALOG_STYLE_INPUT, DLG_NONRP_NAME_HEADER, DLG_NONRP_NAME_STR, DLG_NEXT, DLG_EXIT);
					}
				}
				else PC_EmulateCommand(playerid, "/menu");
			}
			case DLG_MENU03:
			{
				if (response)
				{
					switch (listitem)
					{
						case 0: PC_EmulateCommand(playerid, "/skill");
						case 1: PC_EmulateCommand(playerid, "/skill");
						case 2: PC_EmulateCommand(playerid, "/skill");
						case 3: PC_EmulateCommand(playerid, "/skill");
						case 4: PC_EmulateCommand(playerid, "/skill");
						case 5: PC_EmulateCommand(playerid, "/skill");
						case 6: PC_EmulateCommand(playerid, "/skill");
						case 7: PC_EmulateCommand(playerid, "/skill");
					}
				}
				else PC_EmulateCommand(playerid, "/menu");
			}
			case DLG_NONRP_NAME:
			{
				if (response)
				{
					SCMInfo(playerid, DLG_NONRP_NAME_SUCCESS01_MSG);
					//...
				}
			}
			case DLG_UNBANIP:
			{
				if (response)
				{
					new str[64] = "DELETE FROM `banip_list` WHERE `IP` = '%s'";
					format(str, sizeof(str), str, AINFO[TO_UNBANIP]);
					mysql_query(DBHandle, str, false);

					format(str, sizeof(str), CMD_UNBANIP_SUCCESS01_MSG, PLAYER[NAME], playerid, AINFO[TO_UNBANIP]);
					SAM(str);

					AINFO[TO_UNBANIP][0] = EOS; // end of string
				}
			}
			case DLG_UNBAN:
			{
				if (response)
				{
					new str[256] = "UPDATE `ban_list` SET `Unbanned` = '%s' WHERE `Nickname` = '%s' AND `Unbanned` = 'no' AND `Until` > '%d'";
					format(str, sizeof(str), str, PLAYER[NAME], AINFO[TO_UNBAN], gettime());
					mysql_query(DBHandle, str, false);

					format(str, sizeof(str), CMD_UNBAN_SUCCESS01_MSG, PLAYER[NAME], playerid, AINFO[TO_UNBAN]);
					SAM(str);

					AINFO[TO_UNBAN][0] = EOS; // end of string
				}
			}
		}
	} else SCM(playerid, X_COLOUR_WHITE, "FALSE");
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
		if (clickedid == INVALID_TEXT_DRAW)
		{
			if (PINFO[TEXTDRAW_ID] != 0) SelectTextDraw(playerid, X_COLOUR_NOTIFICATION);
		}

		if (clickedid == TD_REG_SKIN_LEFT)
		{
			regskin_num[playerid]--;
			if (PLAYER[SEX] == 1) // Мужчины
			{
				if (regskin_num[playerid] == -1) regskin_num[playerid] = 3;
				SetPlayerSkin(playerid, regMaleSkins[PLAYER[RACE] - 1][regskin_num[playerid]]);
			}
			else // Женщины
			{
				if (regskin_num[playerid] == -1) regskin_num[playerid] = 2;
				SetPlayerSkin(playerid, regFemaleSkins[PLAYER[RACE] - 1][regskin_num[playerid]]);
			}
		}
		if (clickedid == TD_REG_SKIN_RIGHT)
		{
			regskin_num[playerid]++;
			if (PLAYER[SEX] == 1) // Мужчины
			{
				if (regskin_num[playerid] == 4) regskin_num[playerid] = 0;
				SetPlayerSkin(playerid, regMaleSkins[PLAYER[RACE] - 1][regskin_num[playerid]]);
			}
			else // Женщины
			{
				if (regskin_num[playerid] == 3) regskin_num[playerid] = 0;
				SetPlayerSkin(playerid, regFemaleSkins[PLAYER[RACE] - 1][regskin_num[playerid]]);
			}
		}
		if (clickedid == TD_REG_SKIN_SELECT)
		{
			PINFO[TEXTDRAW_ID] = 0;
			PLAYER[SKIN] = GetPlayerSkin(playerid);
			SaveAccount(playerid);

			TextDrawHideForPlayer(playerid, TD_REG_SKIN_BOX);
			TextDrawHideForPlayer(playerid, TD_REG_SKIN_LEFT);
			TextDrawHideForPlayer(playerid, TD_REG_SKIN_RIGHT);
			TextDrawHideForPlayer(playerid, TD_REG_SKIN_SELECT);
			CancelSelectTextDraw(playerid);

			SCMInfo(playerid, DLG_LOGIN_SUCCESS_MSG);
			PINFO[LOGGED] = true;
			PINFO[AFK] = 0;
			LoadAccount(playerid);

			PINFO[TIMER][1] = SetTimerEx("@_MinuteUpdate", 1000 * 60, true, "i", playerid);

			SpawnPlayerEx(playerid);
			TogglePlayerControllable(playerid, 1);
		}
		return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if ((PINFO[LOGGED]) && (PLAYER[ADMIN] >= CMD_MAPTP_ALVL))
	{
		if (AINFO[SPECTATING] != -1) return SCMError(playerid, CMD_ERROR_SPECTATE01_MSG);

		new Float:z;
		CA_FindZ_For2DCoord(fX, fY, z);
		if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), fX, fY, z + 1.5);
			PutPlayerInVehicle(playerid, GetPlayerVehicleID(playerid), 0);
		}
		else SetPlayerPos(playerid, fX, fY, z + 1.5);

		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerInterior(playerid, 0);

		SCMInfo(playerid, ADMIN_MAP_TP_MSG);
	}
	return 1;
}

// MySQL Funcs
stock MySQLConnect()
{
	DBHandle = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);
	if (mysql_errno() == 0)
	{
		print("[MySQL] БД успешно подключена! [MySQL] Устанавливаем кодировку...");
		print("[MySQL] Устанавливаем все таблицы (если их нет)\n[MySQL] Устанавливаем кодировку...");
		mysql_set_charset("cp1251");

		mysql_query(DBHandle, ACCOUNTS_TAB, false);
		mysql_query(DBHandle, BAN_LIST_TAB, false);
		mysql_query(DBHandle, BANIP_LIST_TAB, false);
	}
	else
	{
		print("[MySQL] Ошибка подключения БД! [MySQL] Останавливаем сервер...");
		SendRconCommand("exit");
	}
	return 1;
}

stock Connection(playerid)
{
	new query[84];
	format(query, sizeof(query), "SELECT * FROM `banip_list` WHERE `IP` = '%s' LIMIT 1", PLAYER[LASTIP]);
	mysql_tquery(DBHandle, query, "@_CheckPlayerBanIP", "ii", playerid, 1);
	return 1;
}

@_CheckPlayerRegistered(playerid, type) // 0 - При входе на сервер, 1 - Проверка реферала, 2 - Получение ID для новорега
{
	new rows;
	cache_get_row_count(rows);

	if (rows)
	{
		switch (type)
		{
			case 0:
			{
				GetAccountData(playerid, 0);
				ShowLoginDialog(playerid);
			}
			case 1: OnRegistrationSuccessful(playerid);
			case 2: mysql_get_int(0, "ID", PLAYER[ID]);
		}
	}
	else
	{
		if (type == 0) ShowRegDialog(playerid);
		else if (type == 1)
		{
			if (PINFO[AUTH_LIMIT] > 1)
			{
				PINFO[AUTH_LIMIT]--;

				ShowRegDialog(playerid, 4);

				new error[MAX_CHAT_STR];
				format(error, sizeof(error), DLG_REG_REFERAL_NOT_FOUND01_MSG, PINFO[AUTH_LIMIT]);
				SCMError(playerid, error);
				SCMError(playerid, DLG_REG_REFERAL_NOT_FOUND02_MSG);
			}
			else
			{
				SCMError(playerid, DLG_REG_REFERAL_KICK_MSG);
				ExitServerDialog(playerid);
			}
		}
	}
}

@_CheckPlayerBanIP(playerid, type) // 1 - При входе, 2 - При разбане
{
	new rows;
	cache_get_row_count(rows);

	if (rows)
	{
		if (type == 1)
		{
			SCMError(playerid, DLG_EXIT_SERVER);

			new str[512], admin[24], reason[80], time;
			mysql_get(0, "Admin", admin);
			mysql_get(0, "Reason", reason);
			mysql_get_int(0, "Time", time);

			format(str, sizeof(str), DLG_BANNEDIP_STR, date(time, GMT, "%02d.%02d.%d в %02d:%02d:%02d"), admin, reason);
			SPD(playerid, DLG_BANNEDIP, DIALOG_STYLE_MSGBOX, DLG_BANNEDIP_HEADER, str, DLG_EXIT, "");

			Kick(playerid);
		}
		else
		{
			new str[512], name[24], IP[16], admin[24], reason[80], time;
			mysql_get(0, "IP", IP);
			mysql_get(0, "Nickname", name);
			mysql_get(0, "Admin", admin);
			mysql_get(0, "Reason", reason);
			mysql_get_int(0, "Time", time);

			AINFO[TO_UNBANIP] = IP;

			format(str, sizeof(str), DLG_UNBANIP_STR, name, IP, date(time, GMT, "%02d.%02d.%d в %02d:%02d:%02d"), admin, reason);
			SPD(playerid, DLG_UNBANIP, DIALOG_STYLE_MSGBOX, DLG_UNBANIP_HEADER, str, DLG_YES, DLG_CANCEL);
		}
	}
	else
	{
		if (type == 1)
		{
			new query[128];
			format(query, sizeof(query), "SELECT * FROM `ban_list` WHERE `Nickname` = '%s' AND `Unbanned` = 'no' AND `Until` > '%d' LIMIT 1", PLAYER[NAME], gettime());
			mysql_tquery(DBHandle, query, "@_CheckPlayerBan", "ii", playerid, 1);
		}
		else SCMError(playerid, CMD_UNBANIP_ERROR02_MSG);
	}
}

@_CheckPlayerBan(playerid, type) // 1 - При входе, 2 - При разбане
{
	new rows;
	cache_get_row_count(rows);

	if (rows)
	{
		if (type == 1)
		{
			SCMError(playerid, DLG_EXIT_SERVER);

			new str[512], admin[24], reason[80], time, until;
			mysql_get(0, "Admin", admin);
			mysql_get(0, "Reason", reason);
			mysql_get_int(0, "Time", time);
			mysql_get_int(0, "Until", until);

			format(str, sizeof(str), DLG_BANNED_STR,
			date(time, GMT, "%02d.%02d.%d в %02d:%02d:%02d"), date(until, GMT, "%02d.%02d.%d в %02d:%02d:%02d"), admin, reason);
			SPD(playerid, DLG_BANNED, DIALOG_STYLE_MSGBOX, DLG_BANNED_HEADER, str, DLG_EXIT, "");

			Kick(playerid);
		}
		else
		{
			new str[512], name[24], IP[16], admin[24], reason[80], time, until;
			mysql_get(0, "LastIP", IP);
			mysql_get(0, "Nickname", name);
			mysql_get(0, "Admin", admin);
			mysql_get(0, "Reason", reason);
			mysql_get_int(0, "Time", time);
			mysql_get_int(0, "Until", until);

			AINFO[TO_UNBAN] = name;

			format(str, sizeof(str), DLG_UNBAN_STR,
			name, IP, date(time, GMT, "%02d.%02d.%d в %02d:%02d:%02d"), date(until, GMT, "%02d.%02d.%d в %02d:%02d:%02d"), admin, reason);
			SPD(playerid, DLG_UNBAN, DIALOG_STYLE_MSGBOX, DLG_UNBAN_HEADER, str, DLG_YES, DLG_CANCEL);
		}
	}
	else
	{
		if (type == 1)
		{
			new query[84];
			format(query, sizeof(query), "SELECT * FROM `accounts` WHERE `Nickname` = '%s' LIMIT 1", PLAYER[NAME]);
			mysql_tquery(DBHandle, query, "@_CheckPlayerRegistered", "ii", playerid, 0);
		}
		else SCMError(playerid, CMD_UNBAN_ERROR02_MSG);
	}
}

stock ShowRegDialog(playerid, type = 1) // 1 - Пароль, 2 - Пол, 3 - Раса, 4 - Реферал
{
	switch (type)
	{
		case 1:
		{
			new dialog[450];
			format(dialog, sizeof(dialog), DLG_REG_PASSWORD_STR, PLAYER[NAME], SERVER_NAME);
			SPD(playerid, DLG_REG, DIALOG_STYLE_INPUT, DLG_REG_PASSWORD_HEADER, dialog, DLG_NEXT, DLG_EXIT);
		}
		case 2: SPD(playerid, DLG_REG_SEX, DIALOG_STYLE_LIST, DLG_REG_SEX_HEADER, DLG_REG_SEX_LIST, DLG_NEXT, DLG_BACK);
		case 3: SPD(playerid, DLG_REG_RACE, DIALOG_STYLE_LIST, DLG_REG_RACE_HEADER, DLG_REG_RACE_LIST, DLG_NEXT, DLG_BACK);
		case 4: SPD(playerid, DLG_REG_REFERAL, DIALOG_STYLE_INPUT, DLG_REG_REFERAL_HEADER, DLG_REG_REFERAL_STR, DLG_NEXT, DLG_SKIP);
	}
}

stock ShowLoginDialog(playerid, type = 1) // 1 - Пароль, -1 - Неверный пароль
{
	switch (type)
	{
		case 1:
		{
			new dialog[160];
			format(dialog, sizeof(dialog), DLG_LOGIN_PASSWORD_STR, PLAYER[NAME], PINFO[AUTH_LIMIT]);
			SPD(playerid, DLG_LOGIN, DIALOG_STYLE_PASSWORD, DLG_LOGIN_PASSWORD_HEADER, dialog, DLG_NEXT, DLG_EXIT);
		}
		case -1:
		{
			new dialog[160];
			format(dialog, sizeof(dialog), DLG_LOGIN_PASSWORD_WRONG_STR, PLAYER[NAME], PINFO[AUTH_LIMIT]);
			SPD(playerid, DLG_LOGIN, DIALOG_STYLE_PASSWORD, DLG_LOGIN_PASSWORD_HEADER, dialog, DLG_NEXT, DLG_EXIT);
		}
	}
}

stock OnRegistrationSuccessful(playerid)
{
	new query[256] = "INSERT INTO `accounts` (`Nickname`, `Password`, `RegIP`, `LastIP`, `Sex`, `Race`, `Referal`) VALUES ('%s', '%s', '%s', '%s', '%d', '%d', '%s')";
	format(query, sizeof(query), query,
	PLAYER[NAME], PLAYER[PASSWORD], PLAYER[LASTIP], PLAYER[LASTIP], PLAYER[SEX], PLAYER[RACE], PLAYER[REFERAL]);
	mysql_query(DBHandle, query, false); // false - не хэшировать

	format(query, sizeof(query), "SELECT `ID` FROM `accounts` WHERE `Nickname` = '%s' LIMIT 1", PLAYER[NAME]);
	mysql_tquery(DBHandle, query, "@_CheckPlayerRegistered", "ii", playerid, 2);

	GetAccountData(playerid, 1);

	ChoosingRegSkin(playerid);
}

stock OnPlayerLoginSuccessful(playerid)
{
	if (PLAYER[SKIN] != -1)
	{
		SCMInfo(playerid, DLG_LOGIN_SUCCESS_MSG);
		PINFO[LOGGED] = true;
		PINFO[AFK] = 0;
		LoadAccount(playerid);

		PINFO[TIMER][1] = SetTimerEx("@_MinuteUpdate", 1000 * 60, true, "i", playerid);

		TogglePlayerSpectating(playerid, 0);
		TogglePlayerControllable(playerid, 1);
	}
	else ChoosingRegSkin(playerid);
}

stock ChoosingRegSkin(playerid)
{
	SCMInfo(playerid, DLG_REG_SUCCESS_MSG);

	PINFO[TEXTDRAW_ID] = 1;
	if (PLAYER[SEX] == 1) SetSpawnInfo(playerid, 0, regMaleSkins[PLAYER[RACE] - 1][0], 195.1295, -107.7875, 1.5488, 90);
	else SetSpawnInfo(playerid, 0, regFemaleSkins[PLAYER[RACE] - 1][0], 195.1295, -107.7875, 1.5488, 90);

	TogglePlayerSpectating(playerid, 0);
	TogglePlayerControllable(playerid, 0);
	SetPlayerVirtualWorld(playerid, playerid + 1 + 1);

	SetPlayerPos(playerid, 196.5753, -107.2689, 1.5496);
	SetPlayerFacingAngle(playerid, 90);

	SetPlayerCameraPos(playerid, 194.1915, -107.6115, 1.5483);
	SetPlayerCameraLookAt(playerid, 196.5753, -107.2689, 1.5496);

	TextDrawShowForPlayer(playerid, TD_REG_SKIN_BOX);
	TextDrawShowForPlayer(playerid, TD_REG_SKIN_LEFT);
	TextDrawShowForPlayer(playerid, TD_REG_SKIN_RIGHT);
	TextDrawShowForPlayer(playerid, TD_REG_SKIN_SELECT);
	SelectTextDraw(playerid, X_COLOUR_NOTIFICATION);
}

stock SpawnPlayerEx(playerid)
{
	if (PINFO[LOGGED])
	{
		switch (PLAYER[SPAWN]) // Спавним игрока в зависимости от его параметров
		{
			case 0: // По лвлу
			{
				switch (PLAYER[LVL])
				{
					case 1..3:
					{
						new pos = random(6);
						SetPlayerPos(playerid, spawn_one[pos][0], spawn_one[pos][1], spawn_one[pos][2]);
						SetPlayerFacingAngle(playerid, spawn_one[pos][3]);
						SetPlayerInterior(playerid, 0);
						SetPlayerVirtualWorld(playerid, 0);
					}
					case 4..7:
					{
						new pos = random(6);
						SetPlayerPos(playerid, spawn_two[pos][0], spawn_two[pos][1], spawn_two[pos][2]);
						SetPlayerFacingAngle(playerid, spawn_two[pos][3]);
						SetPlayerInterior(playerid, 0);
						SetPlayerVirtualWorld(playerid, 0);
					}
					default:
					{
						new pos = random(6);
						SetPlayerPos(playerid, spawn_three[pos][0], spawn_three[pos][1], spawn_three[pos][2]);
						SetPlayerFacingAngle(playerid, spawn_three[pos][3]);
						SetPlayerInterior(playerid, 0);
						SetPlayerVirtualWorld(playerid, 0);
					}
				}
			}
		}
		SetCameraBehindPlayer(playerid);
	}
}

// Авторизация игрока
stock DefaultPlayerData(playerid) // Значения по умолчанию при входе игрока (обнуление переменных и получение некоторых данных)
{
	PINFO[LOGGED] = false;
	PINFO[LAST_COORDS][0] = -1; PINFO[LAST_COORDS][1] = -1; PINFO[LAST_COORDS][2] = -1; PINFO[LAST_COORDS][3] = -1; PINFO[LAST_COORDS][4] = -1;
	PINFO[LAST_DLG_INFO][0] = 0; PINFO[LAST_DLG_INFO][1] = -1; PINFO[LAST_DLG_INFO][0] = -1; PINFO[LAST_DLG_INFO][0] = -1;
	PINFO[AFK] = 0;
	SetPlayerColor(playerid, PLAYER_COLOUR_DEFAULT);
	GetPlayerName(playerid, PLAYER[NAME], 24);
	GetPlayerIp(playerid, PLAYER[LASTIP], 16);
	PINFO[AUTH_LIMIT] = 3;
	PINFO[EXIT_DIALOG] = 5;
	PINFO[TEXTDRAW_ID] = 0;

	AINFO[SPECTATING] = -1;
}

stock GetAccountData(playerid, type = 0) // 0 - При авторизации, 1 - После регистрации
{
	if (type == 0)
	{
		mysql_get_int(0, "ID", PLAYER[ID]);
		mysql_get(0, "Password", PLAYER[PASSWORD], 32 + 1); mysql_get(0, "Mail", PLAYER[MAIL], MAX_MAIL);
		mysql_get(0, "RegIP", PLAYER[REGIP], 16);
		mysql_get_int(0, "Status", PLAYER[STATUS]); mysql_get_int(0, "Donate", PLAYER[DONATE]);
		mysql_get_int(0, "Admin", PLAYER[ADMIN]);
		mysql_get_int(0, "MuteTime", PLAYER[MUTE_TIME]);
		mysql_get_int(0, "Warns", PLAYER[WARNS]); mysql_get_int(0, "LastWarnTime", PLAYER[LAST_WARN_TIME]);
		mysql_get_int(0, "Demorgan", PLAYER[DEMORGAN]);
		mysql_get_int(0, "TimePlayed", PLAYER[TIMEPLAYED]);
		mysql_get_int(0, "LVL", PLAYER[LVL]); mysql_get_int(0, "EXP", PLAYER[EXP]);
		mysql_get_int(0, "Cash", PLAYER[CASH]); mysql_get_int(0, "Bank", PLAYER[BANK]); mysql_get_int(0, "Deposit", PLAYER[DEPOSIT]);
		mysql_get_int(0, "PhoneNum", PLAYER[PHONE]);
		mysql_get_int(0, "Sex", PLAYER[SEX]); mysql_get_int(0, "Race", PLAYER[RACE]); mysql_get_int(0, "Skin", PLAYER[SKIN]);
		mysql_get_int(0, "Spawn", PLAYER[SPAWN]);
		mysql_get_int(0, "Died", PLAYER[DIED]);
		mysql_get_float(0, "HP", PLAYER[HP]); mysql_get_float(0, "ARM", PLAYER[ARM]);
		mysql_get_int(0, "Job", PLAYER[JOB]);
		mysql_get_int(0, "Member", PLAYER[MEMBER]); mysql_get_int(0, "Rank", PLAYER[RANK]);
		mysql_get_int(0, "FMuteTime", PLAYER[FMUTE_TIME]); mysql_get_int(0, "FWarns", PLAYER[FWARNS]);
		mysql_get_int(0, "LawAbiding", PLAYER[LAW_ABIDING]); mysql_get_int(0, "WarningLVL", PLAYER[WARNING_LVL]);
		mysql_get_int(0, "JailTime", PLAYER[JAIL_TIME]); mysql_get_int(0, "JailTimes", PLAYER[JAIL_TIMES]);
		mysql_get(0, "Referal", PLAYER[REFERAL], 24);

		mysql_get_int(0, "Phone", PTHING[PHONE]);
		mysql_get_int(0, "BankCard", PTHING[BANK_CARD]);
	}
	else if (type == 1)
	{
		format(PLAYER[MAIL], MAX_MAIL, "none");
		PLAYER[STATUS] = 0; PLAYER[DONATE] = 0;
		PLAYER[ADMIN] = 0;
		PLAYER[MUTE_TIME] = 0; PLAYER[WARNS] = 0; PLAYER[LAST_WARN_TIME] = 0; PLAYER[DEMORGAN] = 0;
		PLAYER[TIMEPLAYED] = 0;
		PLAYER[LVL] = 1; PLAYER[EXP] = 0;
		PLAYER[CASH] = 200; PLAYER[BANK] = 0; PLAYER[DEPOSIT] = 0;
		PLAYER[PHONE] = 0;
		PLAYER[SKIN] = -1;
		PLAYER[SPAWN] = 0;
		PLAYER[DIED] = 0;
		PLAYER[HP] = 100.0; PLAYER[ARM] = 0;
		PLAYER[JOB] = 0;
		PLAYER[MEMBER] = 0; PLAYER[RANK] = 0; PLAYER[FMUTE_TIME] = 0; PLAYER[FWARNS] = 0;
		PLAYER[LAW_ABIDING] = 0; PLAYER[WARNING_LVL] = 0; PLAYER[JAIL_TIME] = 0; PLAYER[JAIL_TIMES] = 0;

		PTHING[PHONE] = 0;
		PTHING[BANK_CARD] = 0;
	}
}

stock LoadAccount(playerid)
{
	SetPlayerScore(playerid, PLAYER[LVL]);
	AC_SetPlayerCash(playerid, PLAYER[CASH]);
	if (PLAYER[HP] < 15) AC_SetPlayerHealth(playerid, 15);
	else AC_SetPlayerHealth(playerid, PLAYER[HP]);
	AC_SetPlayerArmour(playerid, PLAYER[ARM]);
	SetPlayerSkin(playerid, PLAYER[SKIN]);
}

stock SaveAccount(playerid)
{
	new query[1024] = "UPDATE `accounts` SET \
	`LastIP` = '%s', \
	`Status` = '%d', `Donate` = '%d', \
	`MuteTime` = '%d', `Warns` = '%d', `LastWarnTime` = '%d', `Demorgan` = '%d', \
	`TimePlayed` = '%d', \
	`LVL` = '%d', `EXP` = '%d', \
	`Cash` = '%d', `Bank` = '%d', `Deposit` = '%d', \
	`PhoneNum` = '%d', \
	`Skin` = '%d', \
	`Spawn` = '%d', \
	`Died` = '%d', \
	`HP` = '%f', `ARM` = '%f', \
	`Job` = '%d', \
	`Member` = '%d', `Rank` = '%d', `FMuteTime` = '%d', `FWarns` = '%d', \
	`LawAbiding` = '%d', `WarningLVL` = '%d', `JailTime` = '%d', `JailTimes` = '%d', \
	`Phone` = '%d', `BankCard` = '%d' \
	WHERE `ID` = '%d'";
	format(query, sizeof(query), query,
	PLAYER[LASTIP],
	PLAYER[STATUS], PLAYER[DONATE],
	PLAYER[MUTE_TIME], PLAYER[WARNS], PLAYER[LAST_WARN_TIME], PLAYER[DEMORGAN],
	PLAYER[TIMEPLAYED],
	PLAYER[LVL], PLAYER[EXP],
	PLAYER[CASH], PLAYER[BANK], PLAYER[DEPOSIT],
	PLAYER[PHONE],
	PLAYER[SKIN],
	PLAYER[SPAWN],
	PLAYER[DIED],
	PLAYER[HP], PLAYER[ARM],
	PLAYER[JOB],
	PLAYER[MEMBER], PLAYER[RANK], PLAYER[FMUTE_TIME], PLAYER[FWARNS],
	PLAYER[LAW_ABIDING], PLAYER[WARNING_LVL], PLAYER[JAIL_TIME], PLAYER[JAIL_TIMES],

	PTHING[PHONE], PTHING[BANK_CARD],

	PLAYER[ID]);
	mysql_query(DBHandle, query, false); // false - не хэшировать
}

// Функции для ХП/Брони
stock AC_SetPlayerHealth(playerid, Float:health)
{
	PLAYER[HP] = health;
	SetPlayerHealth(playerid, health);
	return 1;
}

stock AC_AddPlayerHealth(playerid, Float:health)
{
	PLAYER[HP] += health;
	SetPlayerHealth(playerid, PLAYER[HP]);
	return 1;
}

stock AC_SetPlayerArmour(playerid, Float:armour)
{
	PLAYER[ARM] = armour;
	SetPlayerArmour(playerid, armour);
	return 1;
}

stock AC_AddPlayerArmour(playerid, Float:armour)
{
	PLAYER[ARM] += armour;
	SetPlayerArmour(playerid, PLAYER[ARM]);
	return 1;
}

stock AC_Health(playerid)
{
	new Float:health;
	GetPlayerHealth(playerid, health);
	if (health > PLAYER[HP]) SetPlayerHealth(playerid, PLAYER[HP]);
	if (health < PLAYER[HP]) PLAYER[HP] = health;
	return 1;
}

stock AC_Armour(playerid)
{
	new Float:armour;
	GetPlayerArmour(playerid, armour);
	if (armour > PLAYER[ARM]) SetPlayerArmour(playerid, PLAYER[ARM]);
	if (armour < PLAYER[ARM]) PLAYER[ARM] = armour;
	return 1;
}
// Функции для наличных денег
stock AC_SetPlayerCash(playerid, amount)
{
	PLAYER[CASH] = amount;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, amount);
	return 1;
}

stock AC_AddPlayerCash(playerid, amount)
{
	PLAYER[CASH] += amount;
	GivePlayerMoney(playerid, amount);
	return 1;
}

stock AC_Cash(playerid)
{
	if (GetPlayerMoney(playerid) > PLAYER[CASH]) AC_SetPlayerCash(playerid, PLAYER[CASH]);
	return 1;
}

// Функции оружия
stock AC_GivePlayerWeapon(playerid, weaponid, ammo)
{
	PLAYER[AMMO][GetWeaponSlot(weaponid)] += ammo;
	GivePlayerWeapon(playerid, weaponid, ammo);
	return 1;
}

// Античиты
public OnPlayerAirbreak(playerid)
{
	if (PLAYER[ADMIN] == 0)
	{
		new playername[24], string[96];
		GetPlayerName(playerid, playername, sizeof(playername));
		if (IsPlayerInAnyVehicle(playerid))
		{
			format(string,sizeof(string), AC_AIRBREAK_VEHICLE_MSG, playername, playerid, GetPlayerPing(playerid));
			SCMTA(X_COLOUR_SRED, string);
		}
		else
		{
			format(string,sizeof(string), AC_AIRBREAK_FOOT_MSG, playername, playerid, GetPlayerPing(playerid));
			SCMTA(X_COLOUR_SRED, string);
		}
		SCMError(playerid, AC_KICK_MSG);
		return Kick(playerid);
	}
	else return 1;
}

//Команды для админов

// Информационное сообщение для всех админов
stock SAM(str[])
{
	foreach (new i : Player) if (IINFO[LOGGED] && (I[ADMIN] > 0)) SCM(i, X_COLOUR_AACTION, str);
}

CMD:a(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;

	if (sscanf(params, "s[128]", params[0])) return SCMError(playerid, CMD_A_ERROR01_MSG);
	if (strlen(params[0]) > MAX_CHAT_MSG) return SCM(playerid, X_COLOUR_GREY, BIG_TEXT_MSG);

	new str[MAX_CHAT_STR];
	format(str, sizeof(str), CMD_A_SUCCESS01_MSG, PLAYER[NAME], playerid, params[0]);

	foreach (new i : Player) if (IINFO[LOGGED] && (I[ADMIN] > 0)) SCM(i, X_COLOUR_ACHAT, str);

	return 1;
}

CMD:payday(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_PAYDAY_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new amount;
	if (sscanf(params, "i", amount)) return SCMError(playerid, CMD_PAYDAY_ERROR01_MSG);
	if ((amount < 1) || (amount > 4)) return SCMError(playerid, CMD_PAYDAY_ERROR02_MSG);

	PayDay(amount, playerid);

	new str[MAX_CHAT_STR];
	format(str, sizeof(str), CMD_PAYDAY_SUCCESS01_MSG, PLAYER[NAME], playerid, amount);
	SAM(str);

	return 1;
}

CMD:setlvl(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_SETLVL_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new target, amount;
	if (sscanf(params, "ii", target, amount)) return SCMError(playerid, CMD_SETLVL_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);

	if ((amount < 1) || (amount > 1000)) return SCMError(playerid, CMD_ERROR_VALUE_NOT_ALLOWED_MSG);

	new str[MAX_CHAT_STR];
	format(str, sizeof(str), CMD_SETLVL_SUCCESS01_MSG, PLAYER[NAME], playerid, TARGET[NAME], target, TARGET[LVL], amount);
	SAM(str);

	TARGET[LVL] = amount;
	SetPlayerScore(target, TARGET[LVL]);
	SaveAccount(target);

	if (playerid != target)
	{
		format(str, sizeof(str), CMD_SETLVL_SUCCESS02_MSG, PLAYER[NAME], playerid, TARGET[LVL], amount);
		SCMInfo(target, str);
	}

	return 1;
}

CMD:spawn(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_SPAWN_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new target;
	if (sscanf(params, "i", target)) return SCMError(playerid, CMD_SPAWN_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);
	if ((target == playerid) && (AINFO[SPECTATING] != -1)) return SCMError(playerid, CMD_ERROR_SPECTATE01_MSG);

	SpawnPlayerEx(target);

	new str[96];
	format(str, sizeof(str), CMD_SPAWN_SUCCESS01_MSG, PLAYER[NAME], playerid, TARGET[NAME], target);
	SAM(str);

	if (playerid != target)
	{
		format(str, sizeof(str), CMD_SPAWN_SUCCESS02_MSG, PLAYER[NAME], playerid);
		SCMInfo(target, str);
	}

	return 1;
}

CMD:setmoney(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_SETMONEY_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new target, amount;
	if (sscanf(params, "ii", target, amount)) return SCMError(playerid, CMD_SETMONEY_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);

	if ((amount < 0) || (amount > 999_999_999)) return SCMError(playerid, CMD_ERROR_VALUE_NOT_ALLOWED_MSG);

	new str[MAX_CHAT_STR];
	format(str, sizeof(str), CMD_SETMONEY_SUCCESS01_MSG, PLAYER[NAME], playerid, TARGET[NAME], target, PLAYER[CASH], amount);
	SAM(str);

	AC_SetPlayerCash(target, amount);
	SaveAccount(target);

	if (playerid != target)
	{
		format(str, sizeof(str), CMD_SETMONEY_SUCCESS02_MSG, PLAYER[NAME], playerid, amount);
		SCMInfo(target, str);
	}

	return 1;
}

CMD:givemoney(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_GIVEMONEY_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new target, amount;
	if (sscanf(params, "ii", target, amount)) return SCMError(playerid, CMD_GIVEMONEY_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);

	if ((amount < 1) || (amount > 999_999_999)) return SCMError(playerid, CMD_ERROR_VALUE_NOT_ALLOWED_MSG);
	if ((TARGET[CASH] + amount) > 999_999_999) return SCMError(playerid, CMD_GIVEMONEY_ERROR02_MSG);

	new str[MAX_CHAT_STR];
	format(str, sizeof(str), CMD_GIVEMONEY_SUCCESS01_MSG, PLAYER[NAME], playerid, TARGET[NAME], target, amount);
	SAM(str);

	AC_AddPlayerCash(target, amount);
	SaveAccount(target);

	if (playerid != target)
	{
		format(str, sizeof(str), CMD_GIVEMONEY_SUCCESS02_MSG, PLAYER[NAME], playerid, amount);
		SCMInfo(target, str);
	}

	return 1;
}

CMD:removemoney(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_REMOVEMONEY_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new target, amount;
	if (sscanf(params, "ii", target, amount)) return SCMError(playerid, CMD_REMOVEMONEY_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);

	if ((amount < 1) || (amount > 999_999_999)) return SCMError(playerid, CMD_ERROR_VALUE_NOT_ALLOWED_MSG);
	if ((TARGET[CASH] - amount) < 0) return SCMError(playerid, CMD_REMOVEMONEY_ERROR02_MSG);

	AC_AddPlayerCash(target, -amount);
	SaveAccount(target);

	new str[MAX_CHAT_STR];
	format(str, sizeof(str), CMD_REMOVEMONEY_SUCCESS01_MSG, PLAYER[NAME], playerid, TARGET[NAME], target, amount);
	SAM(str);

	if (playerid != target)
	{
		format(str, sizeof(str), CMD_REMOVEMONEY_SUCCESS02_MSG, PLAYER[NAME], playerid, amount);
		SCMInfo(target, str);
	}

	return 1;
}

CMD:sethp(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_SETHP_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new target, amount;
	if (sscanf(params, "ii", target, amount)) return SCMError(playerid, CMD_SETHP_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);

	if ((amount < 0) || (amount > 100)) return SCMError(playerid, CMD_ERROR_VALUE_NOT_ALLOWED_MSG);

	new str[MAX_CHAT_STR];
	format(str, sizeof(str), CMD_SETHP_SUCCESS01_MSG, PLAYER[NAME], playerid, TARGET[NAME], target, amount);
	SAM(str);

	AC_SetPlayerHealth(target, amount);

	if (playerid != target)
	{
		format(str, sizeof(str), CMD_SETHP_SUCCESS02_MSG, PLAYER[NAME], playerid, amount);
		SCMInfo(target, str);
	}

	return 1;
}

CMD:setarm(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_SETARM_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new target, amount;
	if (sscanf(params, "ii", target, amount)) return SCMError(playerid, CMD_SETARM_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);

	if ((amount < 0) || (amount > 100)) return SCMError(playerid, CMD_ERROR_VALUE_NOT_ALLOWED_MSG);

	AC_SetPlayerArmour(target, amount);

	new str[MAX_CHAT_STR];
	format(str, sizeof(str), CMD_SETARM_SUCCESS01_MSG, PLAYER[NAME], playerid, TARGET[NAME], target, amount);
	SAM(str);

	if (playerid != target)
	{
		format(str, sizeof(str), CMD_SETARM_SUCCESS02_MSG, PLAYER[NAME], playerid, amount);
		SCMInfo(target, str);
	}

	return 1;
}

CMD:makeadmin(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_MAKEADMIN_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new target, alvl;
	if (sscanf(params, "ii", target, alvl)) return SCMError(playerid, CMD_MAKEADMIN_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);

	if (target == playerid) return SCMError(playerid, CMD_MAKEADMIN_ERROR02_MSG);
	if ((alvl < 1) || (alvl > 4)) return SCMError(playerid, CMD_ERROR_VALUE_NOT_ALLOWED_MSG);

	TARGET[ADMIN] = alvl;
	new query[128] = "UPDATE `accounts` SET `Admin` = '%d' WHERE `ID` = '%d'";
	format(query, sizeof(query), query, alvl, TARGET[ID]);
	mysql_query(DBHandle, query, false); // false - не хэшировать

	new str[MAX_CHAT_STR];
	format(str, sizeof(str), CMD_MAKEADMIN_SUCCESS01_MSG, PLAYER[NAME], playerid, TARGET[NAME], target, alvl);
	SAM(str);

	format(str, sizeof(str), CMD_MAKEADMIN_SUCCESS02_MSG, PLAYER[NAME], playerid, alvl);
	SCMInfo(target, str);

	return 1;
}

CMD:fireadmin(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_FIREADMIN_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new target;
	if (sscanf(params, "i", target)) return SCMError(playerid, CMD_FIREADMIN_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);

	if (target == playerid) return SCMError(playerid, CMD_FIREADMIN_ERROR02_MSG);
	if (TARGET[ADMIN] == 0) return SCMError(playerid, CMD_FIREADMIN_ERROR03_MSG);

	new str[MAX_CHAT_STR];
	TARGET[ADMIN] = 0;
	format(str, sizeof(str), "UPDATE `accounts` SET `Admin` = '0' WHERE `ID` = '%d'", TARGET[ID]);
	mysql_query(DBHandle, str, false); // false - не хэшировать

	format(str, sizeof(str), CMD_FIREADMIN_SUCCESS01_MSG, PLAYER[NAME], playerid, TARGET[NAME], target);
	SAM(str);

	format(str, sizeof(str), CMD_FIREADMIN_SUCCESS02_MSG, PLAYER[NAME], playerid);
	SCMInfo(target, str);

	return 1;
}

CMD:kick(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_KICK_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new target, reason[80];
	if (sscanf(params, "is[80]", target, reason)) return SCMError(playerid, CMD_KICK_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || (!TINFO[LOGGED]))
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);

	if (target == playerid) return SCMError(playerid, CMD_KICK_ERROR02_MSG);

	new str[300];
	format(str, sizeof(str), CMD_KICK_SUCCESS02_MSG, PLAYER[NAME], playerid, TARGET[NAME], target, reason);
	SCMTA(X_COLOUR_SRED, str);

	SCMInfo(target, CMD_KICK_SUCCESS01_MSG);
	format(str, sizeof(str), DLG_KICK_STR, PLAYER[NAME], reason);
	SPD(target, DLG_KICK, DIALOG_STYLE_MSGBOX, DLG_KICK_HEADER, str, DLG_EXIT, "");

	Kick(target);

	return 1;
}

CMD:banip(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_BANIP_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new target, reason[80];
	if (sscanf(params, "is[80]", target, reason)) return SCMError(playerid, CMD_BANIP_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);

	if (target == playerid) return SCMError(playerid, CMD_BANIP_ERROR02_MSG);

	new str[MAX_CHAT_STR + 90];
	format(str, sizeof(str), "INSERT INTO `banip_list` (`IP`, `Nickname`, `Admin`, `Reason`, `Time`) VALUES ('%s', '%s' ,'%s', '%s', '%d')",
	TARGET[LASTIP], TARGET[NAME], PLAYER[NAME], reason, gettime());
	mysql_query(DBHandle, str, false); // false - не хэшировать

	format(str, sizeof(str), CMD_BANIP_SUCCESS02_MSG, PLAYER[NAME], playerid, TARGET[NAME], target, reason);
	SCMTA(X_COLOUR_SRED, str);

	SCMInfo(target, CMD_BANIP_SUCCESS01_MSG);
	format(str, sizeof(str), DLG_BANIP_STR, PLAYER[NAME], reason);
	SPD(target, DLG_BANIP, DIALOG_STYLE_MSGBOX, DLG_BANIP_HEADER, str, DLG_CLOSE, "");

	Kick(target);

	return 1;
}

CMD:unbanip(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_UNBANIP_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new str[24];
	if (sscanf(params, "s[24]", str)) return SCMError(playerid, CMD_UNBANIP_ERROR01_MSG);

	new query[MAX_CHAT_STR];
	if (RegexCheck(str, "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"))
	format(query, sizeof(query), "SELECT * FROM `banip_list` WHERE `IP` = '%s'", str);
	else format(query, sizeof(query), "SELECT * FROM `banip_list` WHERE `Nickname` = '%s'", str);

	mysql_tquery(DBHandle, query, "@_CheckPlayerBanIP", "ii", playerid, 2);

	return 1;
}

CMD:ban(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_BAN_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new target, time, reason[80];
	if (sscanf(params, "iis[80]", target, time, reason)) return SCMError(playerid, CMD_BAN_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);
	if ((time < 1) || (time > 7000)) return SCMError(playerid, CMD_BAN_ERROR03_MSG);

	if (target == playerid) return SCMError(playerid, CMD_BAN_ERROR02_MSG);

	new str[350];
	format(str, sizeof(str), CMD_BAN_SUCCESS02_MSG, PLAYER[NAME], playerid, TARGET[NAME], target,  time, reason);
	SCMTA(X_COLOUR_SRED, str);

	time = gettime() + (time * 24 * 60 * 60); // < 2^31

	format(str, sizeof(str), "INSERT INTO `ban_list` (`Nickname`, `LastIP`, `Admin`, `Reason`, `Time`, `Until`) VALUES ('%s', '%s' ,'%s', '%s', '%d', '%d')",
	TARGET[NAME], TARGET[LASTIP], PLAYER[NAME], reason, gettime(), time);
	mysql_query(DBHandle, str, false); // false - не хэшировать

	SCMInfo(target, CMD_BAN_SUCCESS01_MSG);
	format(str, sizeof(str), DLG_BAN_STR, PLAYER[NAME], date(time, GMT, "%02d.%02d.%d в %02d:%02d:%02d"), reason);
	SPD(target, DLG_BAN, DIALOG_STYLE_MSGBOX, DLG_BAN_HEADER, str, DLG_CLOSE, "");

	Kick(target);

	return 1;
}

CMD:unban(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_UNBAN_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new str[24];
	if (sscanf(params, "s[24]", str)) return SCMError(playerid, CMD_UNBAN_ERROR01_MSG);

	new query[150];
	format(query, sizeof(query), "SELECT * FROM `ban_list` WHERE `Nickname` = '%s' AND `Unbanned` = 'no' AND `Until` > '%d'",
	str, gettime());

	mysql_tquery(DBHandle, query, "@_CheckPlayerBan", "ii", playerid, 2);

	return 1;
}

CMD:goto(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_GOTO_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);
	if (AINFO[SPECTATING] != -1) return SCMError(playerid, CMD_ERROR_SPECTATE01_MSG);

	new target;
	if (sscanf(params, "i", target)) return SCMError(playerid, CMD_GOTO_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);

	if (target == playerid) return SCMError(playerid, CMD_GOTO_ERROR02_MSG);

	GetPlayerPos(playerid, PINFO[LAST_COORDS][0], PINFO[LAST_COORDS][1], PINFO[LAST_COORDS][2]);
	PINFO[LAST_COORDS][3] = GetPlayerInterior(playerid);
	PINFO[LAST_COORDS][4] = GetPlayerVirtualWorld(playerid);

	new Float:x, Float:y, Float:z;
	GetPlayerPos(target, x, y, z);
	SetPlayerInterior(playerid, GetPlayerInterior(target));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(target));
	if (IsPlayerInAnyVehicle(playerid)) return SetVehiclePos(GetPlayerVehicleID(playerid), x + 1, y + 1, z);
	SetPlayerPos(playerid, x + 1, y + 1, z);

	new str[MAX_CHAT_STR];
	format(str, sizeof(str), CMD_GOTO_SUCCESS01_MSG, TARGET[NAME], target);
	SCMInfo(playerid, str);

	return 1;
}

CMD:gethere(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_GETHERE_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);
	if (AINFO[SPECTATING] != -1) return SCMError(playerid, CMD_ERROR_SPECTATE01_MSG);

	new target;
	if (sscanf(params, "i", target)) return SCMError(playerid, CMD_GETHERE_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);

	if (target == playerid) return SCMError(playerid, CMD_GETHERE_ERROR02_MSG);

	GetPlayerPos(target, TINFO[LAST_COORDS][0], TINFO[LAST_COORDS][1], TINFO[LAST_COORDS][2]);
	TINFO[LAST_COORDS][3] = GetPlayerInterior(target);
	TINFO[LAST_COORDS][4] = GetPlayerVirtualWorld(target);

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPlayerInterior(target, GetPlayerInterior(playerid));
	SetPlayerVirtualWorld(target, GetPlayerVirtualWorld(playerid));
	SetPlayerPos(target, x + 1, y + 1, z);

	new str[MAX_CHAT_STR];
	format(str, sizeof(str), CMD_GETHERE_SUCCESS01_MSG, target);
	SCMInfo(playerid, str);

	format(str, sizeof(str), CMD_GETHERE_SUCCESS02_MSG, PLAYER[NAME], playerid);
	SCMInfo(target, str);

	return 1;
}

CMD:goback(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_GOBACK_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);
	if (AINFO[SPECTATING] != -1) return SCMError(playerid, CMD_ERROR_SPECTATE01_MSG);

	if ((PINFO[LAST_COORDS][0] == -1) && (PINFO[LAST_COORDS][1] == -1) && (PINFO[LAST_COORDS][2] == -1) && (PINFO[LAST_COORDS][3] == -1) && (PINFO[LAST_COORDS][4] == -1))
	return SCMError(playerid, CMD_GOBACK_ERROR01_MSG);

	SetPlayerInterior(playerid, PINFO[LAST_COORDS][3]);
	SetPlayerVirtualWorld(playerid, PINFO[LAST_COORDS][4]);
	SetPlayerPos(playerid, PINFO[LAST_COORDS][0], PINFO[LAST_COORDS][1], PINFO[LAST_COORDS][2]);

	PINFO[LAST_COORDS][0] = -1; PINFO[LAST_COORDS][1] = -1; PINFO[LAST_COORDS][2] = -1; PINFO[LAST_COORDS][3] = -1; PINFO[LAST_COORDS][4] = -1;

	SCMInfo(playerid, CMD_GOBACK_SUCCESS01_MSG);

	return 1;
}

CMD:getback(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_GETBACK_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);
	if (AINFO[SPECTATING] != -1) return SCMError(playerid, CMD_ERROR_SPECTATE01_MSG);

	new target;
	if (sscanf(params, "i", target)) return SCMError(playerid, CMD_GETBACK_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);

	if (target == playerid) return SCMError(playerid, CMD_GETBACK_ERROR02_MSG);
	if ((TINFO[LAST_COORDS][0] == -1) && (TINFO[LAST_COORDS][1] == -1) && (TINFO[LAST_COORDS][2] == -1) && (TINFO[LAST_COORDS][3] == -1) && (TINFO[LAST_COORDS][4] == -1))
	return SCMError(playerid, CMD_GETBACK_ERROR03_MSG);

	SetPlayerInterior(target, TINFO[LAST_COORDS][3]);
	SetPlayerVirtualWorld(target, TINFO[LAST_COORDS][4]);
	SetPlayerPos(target, TINFO[LAST_COORDS][0], TINFO[LAST_COORDS][1], TINFO[LAST_COORDS][2]);

	TINFO[LAST_COORDS][0] = -1; TINFO[LAST_COORDS][1] = -1; TINFO[LAST_COORDS][2] = -1; TINFO[LAST_COORDS][3] = -1; TINFO[LAST_COORDS][4] = -1;

	new str[MAX_CHAT_STR];
	format(str, sizeof(str), CMD_GETBACK_SUCCESS01_MSG, PLAYER[NAME], playerid);
	SCMInfo(target, str);

	return 1;
}

CMD:slap(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_SLAP_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new target;
	if (sscanf(params, "i", target)) return SCMError(playerid, CMD_SLAP_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);

	new Float:x, Float:y, Float:z;
	GetPlayerPos(target, x, y, z);
	SetPlayerPos(target, x, y, z + 5);

	new str[MAX_CHAT_STR];
	format(str, sizeof(str), CMD_SLAP_SUCCESS01_MSG, PLAYER[NAME], playerid, TARGET[NAME], target);
	SAM(str);

	if (playerid != target)
	{
		format(str, sizeof(str), CMD_SLAP_SUCCESS02_MSG, PLAYER[NAME], playerid);
		SCMInfo(target, str);
	}

	return 1;
}

CMD:re(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_RE_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	new target;
	if (sscanf(params, "i", target)) return SCMError(playerid, CMD_RE_ERROR01_MSG);
	if ((target < 0) || (target > MAX_PLAYERS) || !TINFO[LOGGED])
	return SCMError(playerid, CMD_ERROR_PLAYER_NOT_FOUND_MSG);

	if (playerid == target) return SCMError(playerid, CMD_RE_ERROR02_MSG);
	if (ainfo[target][SPECTATING] != -1) return SCMError(playerid, CMD_ERROR_SPECTATE02_MSG);

	AINFO[SPECTATING] = target;

	GetPlayerPos(playerid, PINFO[LAST_COORDS][0], PINFO[LAST_COORDS][1], PINFO[LAST_COORDS][2]);
	PINFO[LAST_COORDS][3] = GetPlayerInterior(playerid);
	PINFO[LAST_COORDS][4] = GetPlayerVirtualWorld(playerid);

	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(target));
	SetPlayerInterior(playerid, GetPlayerInterior(target));

	TogglePlayerSpectating(playerid, 1);
	if (IsPlayerInAnyVehicle(target)) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(target), SPECTATE_MODE_NORMAL);
	else PlayerSpectatePlayer(playerid, target, SPECTATE_MODE_NORMAL);

	new str[MAX_CHAT_STR];
	format(str, sizeof(str), CMD_RE_SUCCESS01_MSG, PLAYER[NAME], playerid, TARGET[NAME], target);
	SAM(str);

	return 1;
}

CMD:reoff(playerid, params[])
{
	if ((!PINFO[LOGGED]) || (PLAYER[ADMIN] == 0)) return 0;
	if (PLAYER[ADMIN] < CMD_REOFF_ALVL) return SCMError(playerid, CMD_ERROR_LOW_ALVL_MSG);

	if (AINFO[SPECTATING] == -1) return SCMError(playerid, CMD_REOFF_ERROR01_MSG);

	TogglePlayerSpectating(playerid, 0);

	return 1;
}


//Команды для игроков
CMD:me(playerid, params[])
{
	if (PINFO[LOGGED])
	{
		if (sscanf(params, "s[128]", params[0])) return SCMError(playerid, CMD_ME_ERROR01_MSG);
		if (strlen(params[0]) > MAX_CHAT_MSG) return SCM(playerid, X_COLOUR_GREY, BIG_TEXT_MSG);

		new string[MAX_CHAT_STR];
		format(string, sizeof(string), "%s %s", PLAYER[NAME], params[0]);
		LocalChat(playerid, string, X_COLOUR_ME);
		SetPlayerChatBubble(playerid, params[0], X_COLOUR_ME, CHATBUBBLE_RADIUS, 1000 * 5);
		return 1;
	}
	return 0;
}

CMD:do(playerid, params[])
{
	if (PINFO[LOGGED])
	{
		if (sscanf(params, "s[128]", params[0])) return SCMError(playerid, CMD_DO_ERROR01_MSG);
		if (strlen(params[0]) > MAX_CHAT_MSG) return SCM(playerid, X_COLOUR_GREY, BIG_TEXT_MSG);

		new string[MAX_CHAT_STR];
		format(string, sizeof(string),"%s  - |  %s", params[0], PLAYER[NAME]);
		LocalChat(playerid, string, X_COLOUR_DO);
		return 1;
	}
	return 0;
}

CMD:try(playerid, params[])
{
	if (PINFO[LOGGED])
	{
		if (sscanf(params, "s[128]", params[0])) return SCMError(playerid, CMD_TRY_ERROR01_MSG);
		if (strlen(params[0]) > MAX_CHAT_MSG) return SCM(playerid, X_COLOUR_GREY, BIG_TEXT_MSG);

		new string[MAX_CHAT_STR];
		if (random(2) == 0)
		{
			format(string, sizeof(string), CMD_TRY_SUCCESS_MSG, PLAYER[NAME], params[0]);
			SetPlayerChatBubble(playerid, CMD_TRY_SUCCESS_STR, X_COLOUR_LGREEN, CHATBUBBLE_RADIUS, 1000 * 5);
		}
		else
		{
			format(string, sizeof(string), CMD_TRY_FAIL_MSG, PLAYER[NAME], params[0]);
			SetPlayerChatBubble(playerid, CMD_TRY_FAIL_STR, X_COLOUR_RED, CHATBUBBLE_RADIUS, 1000 * 5);
		}

		LocalChat(playerid, string, X_COLOUR_ME);
		return 1;
	}
	return 0;
}

CMD:todo(playerid, params[])
{
	if(PINFO[LOGGED])
	{
		new str[MAX_CHAT_STR];
		if (sscanf(params, "p<*>s[128]s[128]", params[0], str)) return SCMError(playerid, CMD_TODO_ERROR01_MSG);
		if ((strlen(params[0]) + strlen(str)) > MAX_CHAT_MSG) return SCM(playerid, X_COLOUR_GREY, BIG_TEXT_MSG);

		format(str, sizeof(str), CMD_TODO_SUCCESS01_MSG, params[0], PLAYER[NAME], str);

		LocalChat(playerid, str);
		return 1;
	}
	return 0;
}

CMD:n(playerid, params[])
{
	if(PINFO[LOGGED])
	{
		if (sscanf(params, "s[128]", params[0])) return SCMError(playerid, CMD_N_ERROR01_MSG);
		if (strlen(params[0]) > MAX_CHAT_MSG) return SCM(playerid, X_COLOUR_GREY, BIG_TEXT_MSG);

		new str[MAX_CHAT_STR];
		format(str, sizeof(str), CMD_N_SUCCESS01_MSG, PLAYER[NAME], playerid, params[0]);
		LocalChat(playerid, str);
		return 1;
	}
	return 0;
}

CMD:s(playerid, params[])
{
	if(PINFO[LOGGED])
	{
		if (sscanf(params, "s[128]", params[0])) return SCMError(playerid, CMD_S_ERROR01_MSG);
		if (strlen(params[0]) > MAX_CHAT_MSG) return SCM(playerid, X_COLOUR_GREY, BIG_TEXT_MSG);

		new str[MAX_CHAT_STR];
		format(str, sizeof(str), CMD_S_SUCCESS01_MSG, PLAYER[NAME], playerid, params[0]);
		LocalChat(playerid, str, X_COLOUR_LOUD, CHAT_RADIUS + 10);
		SetPlayerChatBubble(playerid, params[0], X_COLOUR_LOUD, CHATBUBBLE_RADIUS, 1000 * 5);
		if(!IsPlayerInAnyVehicle(playerid))	ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 1500.0, 0, 0, 0, 0, 0, 1);
		return 1;
	}
	return 0;
}

CMD:c(playerid, params[])
{
	if(PINFO[LOGGED])
	{
		if (sscanf(params, "s[128]", params[0])) return SCMError(playerid, CMD_C_ERROR01_MSG);
		if (strlen(params[0]) > MAX_CHAT_MSG) return SCM(playerid, X_COLOUR_GREY, BIG_TEXT_MSG);

		new str[MAX_CHAT_STR];
		format(str, sizeof(str), CMD_C_SUCCESS01_MSG, PLAYER[NAME], playerid, params[0]);
		LocalChat(playerid, str, X_COLOUR_MARIA, CHAT_RADIUS - 10);
		SetPlayerChatBubble(playerid, params[0], X_COLOUR_GREY, CHATBUBBLE_RADIUS, 1000 * 5);
		return 1;
	}
	return 0;
}

CMD:menu(playerid, params[])
{
	if(PINFO[LOGGED])
	{
		SPD(playerid, DLG_MENU01, DIALOG_STYLE_LIST, DLG_MENU01_HEADER, DLG_MENU01_LIST, DLG_SELECT, DLG_CANCEL);
		return 1;
	}
	return 0;
}

CMD:stats(playerid, params[])
{
	if(PINFO[LOGGED])
	{
		new sex, race, job, organisation, phone, bankid, status;
		new str[1024] = DLG_STATS01_STR;
		format(str, sizeof(str), str,
		PLAYER[NAME], GetStringByVar(playerid, "SEX"), GetStringByVar(playerid, "RACE"),
		PLAYER[LVL], PLAYER[EXP], 8 + (2 * (PLAYER[LVL] - 1)),
		PLAYER[CASH], PLAYER[BANK], PLAYER[DEPOSIT],
		GetStringByVar(playerid, "JOB"), GetStringByVar(playerid, "MEMBER"), PLAYER[LAW_ABIDING], PLAYER[WARNING_LVL],
		GetStringByVar(playerid, "PHONE"), GetStringByVar(playerid, "BANKID"),
		GetStringByVar(playerid, "STATUS"), PLAYER[DONATE], PLAYER[WARNS]);
		SPD(playerid, DLG_STATS01, DIALOG_STYLE_MSGBOX, DLG_STATS01_HEADER, str, "Предметы", DLG_EXIT);
		return 1;
	}
	return 0;
}


stock GetStringByVar(playerid, type[])
{
	new str[32];

	if (!strcmp(type, "SEX"))
	{
		if (PLAYER[SEX] == 1) format(str, sizeof(str), "Мужчина");
		else format(str, sizeof(str), "Женщина");
		return str;
	}

	if (!strcmp(type, "RACE"))
	{
		switch (PLAYER[RACE])
		{
			case 1:
			{
				if (PLAYER[SEX] == 1) format(str, sizeof(str), "Европеец");
				else format(str, sizeof(str), "Европейка");
			}
			case 2:
			{
				if (PLAYER[SEX] == 1) format(str, sizeof(str), "Афроамериканец");
				else format(str, sizeof(str), "Афроамериканка");
			}
			case 3:
			{
				if (PLAYER[SEX] == 1) format(str, sizeof(str), "Азиат");
				else format(str, sizeof(str), "Азиатка");
			}
		}
		return str;
	}

	if (!strcmp(type, "JOB"))
	{
		switch (PLAYER[MEMBER])
		{
			case 0: format(str, sizeof(str), "Безработный");
			case 1: format(str, sizeof(str), "Фермер");
			//..
		}
		return str;
	}

	if (!strcmp(type, "MEMBER"))
	{
		switch (PLAYER[MEMBER])
		{
			case 0: format(str, sizeof(str), "Отсутствует");
			case 1: format(str, sizeof(str), "Правительство");
			//..
		}
		return str;
	}

	if (!strcmp(type, "PHONE"))
	{
		if (PTHING[PHONE] != 0) valstr(str, PTHING[PHONE]);
		else format(str, sizeof(str), "Отсутствует");
		return str;
	}

	if (!strcmp(type, "BANKID"))
	{
		if (PTHING[BANK_CARD] != 0) valstr(str, PLAYER[ID]);
		else format(str, sizeof(str), "Отсутствует");
		return str;
	}

	if (!strcmp(type, "STATUS"))
	{
		switch (PLAYER[STATUS])
		{
			case 0: format(str, sizeof(str), "Игрок");
			case 1: format(str, sizeof(str), "VIP-1");
			//..
		}
		return str;
	}
}
