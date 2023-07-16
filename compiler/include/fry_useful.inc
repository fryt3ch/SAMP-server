#pragma library fry_useful

// Colours
#define X_COLOUR_BLACK 0x000000FF
#define X_COLOUR_WHITE 0xFFFFFFFF
#define X_COLOUR_GREY 0xB7AFAFFF
#define X_COLOUR_RED 0xFF0000FF
#define X_COLOUR_YELLOW 0xF3FF02FF
#define X_COLOUR_SRED 0xD02727FF
#define X_COLOUR_LGREEN 0x2DBE0FFF
#define X_COLOUR_DOLLAR 0x73B461FF
#define X_COLOUR_ME	0xD85EF1FF
#define X_COLOUR_DO	0x4682B4FF
#define X_COLOUR_MARIA	0x94B0C1FF // Морской
#define X_COLOUR_LOUD 0xF6D049FF // Когда игрок кричит

#define X_COLOUR_NOTIFICATION 0xFF7300FF
#define X_COLOUR_ERROR 0xD02727FF
#define X_COLOUR_ACHAT 0xF3FF02FF
#define X_COLOUR_AACTION 0xB7AFAFFF

#define COLOUR_NOTIFICATION FF7300
#define COLOUR_ERROR D02727
#define COLOUR_ACHAT F3FF02
#define COLOUR_AACTION B7AFAF

#define COLOUR_BLACK 000000
#define COLOUR_WHITE FFFFFF
#define COLOUR_GREY B7AFAF
#define COLOUR_RED FF0000
#define COLOUR_YELLOW F3FF02
#define COLOUR_SRED D02727
#define COLOUR_LGREEN 2DBE0F
#define COLOUR_DOLLAR 73B461
#define COLOUR_ME	D85EF1
#define COLOUR_DO 4682B4
#define COLOUR_MARIA 94B0C1 // Морской
#define COLOUR_LOUD F6D049 // Когда игрок кричит

// Player Colours
#define PLAYER_COLOUR_DEFAULT 0xFFFFFFFF

// Shortened CMD's
#define SCM SendClientMessage
#define SCMTA SendClientMessageToAll
#define SPD ShowPlayerDialogEx

#define mysql_get cache_get_value_name
#define mysql_get_int cache_get_value_name_int
#define mysql_get_float cache_get_value_name_float

#define MES mysql_escape_string

// MySQL Таблицы
#define ACCOUNTS_TAB "\
CREATE TABLE IF NOT EXISTS `accounts` (\
	`ID` int(11) NOT NULL AUTO_INCREMENT,\
	`Nickname` varchar(24) NOT NULL,\
	`Password` varchar(32) NOT NULL,\
	`Mail` varchar(42) NOT NULL DEFAULT 'none',\
	`RegIP` varchar(16) NOT NULL,\
	`LastIP` varchar(16) NOT NULL,\
	`Status` int(2) NOT NULL DEFAULT '0',\
	`Donate` int(9) NOT NULL DEFAULT '0',\
	`Admin` int(11) NOT NULL DEFAULT '0',\
	`MuteTime` int(11) NOT NULL DEFAULT '0',\
	`Warns` int(2) NOT NULL DEFAULT '0',\
	`LastWarnTime` int(11) NOT NULL DEFAULT '0',\
	`Demorgan` int(11) NOT NULL DEFAULT '0',\
	`TimePlayed` int(2) NOT NULL DEFAULT '0',\
	`LVL` int(11) NOT NULL DEFAULT '1',\
	`EXP` int(11) NOT NULL DEFAULT '0',\
	`Cash` int(9) NOT NULL DEFAULT '200',\
	`Bank` int(9) NOT NULL DEFAULT '0',\
	`Deposit` int(9) NOT NULL DEFAULT '0',\
	`PhoneNum` int(9) NOT NULL DEFAULT '0',\
	`Sex` int(1) NOT NULL,\
	`Race` int(1) NOT NULL,\
	`Skin` int(3) NOT NULL DEFAULT '-1',\
	`Spawn` int(2) NOT NULL DEFAULT '0',\
	`Died` int(2) NOT NULL DEFAULT '0',\
	`HP` float NOT NULL DEFAULT '100.0',\
	`ARM` float NOT NULL DEFAULT '0',\
	`Job` int(4) NOT NULL DEFAULT '0',\
	`Member` int(4) NOT NULL DEFAULT '0',\
	`Rank` int(4) NOT NULL DEFAULT '0',\
	`FMuteTime` int(11) NOT NULL DEFAULT '0',\
	`FWarns` int(2) NOT NULL DEFAULT '0',\
	`LawAbiding` int(3) NOT NULL DEFAULT '25',\
	`WarningLVL` int(1) NOT NULL DEFAULT '0',\
	`JailTime` int(11) NOT NULL DEFAULT '0',\
	`JailTimes` int(9) NOT NULL DEFAULT '0',\
	`Referal` varchar(24) NOT NULL DEFAULT 'none',\
	\
	`Phone` int(1) NOT NULL DEFAULT '0',\
	`BankCard` int(1) NOT NULL DEFAULT '0',\
	PRIMARY KEY (`ID`)\
	) ENGINE=InnoDB DEFAULT CHARSET=cp1251 AUTO_INCREMENT=1;"

#define BANIP_LIST_TAB "\
CREATE TABLE IF NOT EXISTS `banip_list` (\
	`ID` int(11) NOT NULL AUTO_INCREMENT,\
	`IP` varchar(16) NOT NULL,\
	`Nickname` varchar(24) NOT NULL,\
	`Admin` varchar(24) NOT NULL,\
	`Reason` varchar(128) NOT NULL,\
	`Time` int(16) NOT NULL,\
	PRIMARY KEY (`ID`)\
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 AUTO_INCREMENT=1;"

#define BAN_LIST_TAB "\
CREATE TABLE IF NOT EXISTS `ban_list` (\
	`ID` int(11) NOT NULL AUTO_INCREMENT,\
	`Nickname` varchar(24) NOT NULL,\
	`LastIP` varchar(16) NOT NULL,\
	`Admin` varchar(24) NOT NULL,\
	`Reason` varchar(128) NOT NULL,\
	`Time` int(16) NOT NULL,\
	`Until` int(16) NOT NULL,\
	`Unbanned` varchar(24) NOT NULL DEFAULT 'no',\
	PRIMARY KEY (`ID`)\
	) ENGINE=InnoDB DEFAULT CHARSET=cp1251 AUTO_INCREMENT=1;"

// Spawn Positions
new Float:spawn_one[6][4] =
{
	{173.3552, -103.5594, 1.5459, 270.0}, // 1 точка
	{173.5248, -111.9235, 1.5458, 270.0}, // 2 точка
	{172.2088, -107.7283, 1.5468, 270.0}, // 3 точка

	{194.7196, -111.3535, 1.5497, 90.0}, // 4 точка
	{194.5130, -107.2286, 1.5486, 90.0}, // 5 точка
	{194.2536, -102.9389, 1.5495, 90.0} // 6 точка
};

new Float:spawn_two[6][4] =
{
	{2858.7896, 1284.2074, 11.3906, 360.0}, // 1 точка
	{2852.8738, 1290.4459, 11.3906, 90.0}, // 2 точка
	{2841.4443, 1291.0612, 11.3906, 90.0}, // 3 точка

	{2838.5093, 1278.3502, 11.3906, 90.0}, // 4 точка
	{2806.3464, 1255.0568, 11.3125, 3.5398}, // 5 точка
	{2790.5178, 1254.8187, 11.3125, 1.4090} // 6 точка
};

new Float:spawn_three[6][4] =
{
	{1433.6653, 2651.0569, 11.3926, 1.0770}, // 1 точка
	{1425.5293, 2641.5874, 11.3926, 265.9065}, // 2 точка
	{1442.1622, 2641.8081, 11.3926, 87.9941}, // 3 точка

	{1433.5050, 2621.3926, 11.3926, 178.1932}, // 4 точка
	{1426.1333, 2627.1235, 11.3926, 260.4938}, // 5 точка
	{1441.9515, 2626.5657, 11.3926, 98.2926} // 6 точка
};

// Registration Skins
new regMaleSkins[3][4] =
{
	{135, 230, 160, 200}, // Европейцы
	{79, 134, 136, 4}, // Афроамериканцы
	{137, 212, 239, 235} // Азиаты
};

new regFemaleSkins[3][3] =
{
	{226, 77, 89}, // Европейки
	{218, 10, 69}, //Афроамериканки
	{53, 54, 196} // Азиатки
};

new regskin_num[MAX_PLAYERS] = 0;

// Функции
stock RegexCheck(text[], _pattern[])
{
	new Regex:pattern = Regex_New(_pattern);
	return(Regex_Check(text, pattern));
}

stock HidePlayerDialog(playerid)
{
	return SPD(playerid, -1, 0, " ", " ", " ", "");
}

stock ExitServerDialog(playerid)
{
	SCM(playerid, X_COLOUR_SRED, DLG_EXIT_SERVER);
	HidePlayerDialog(playerid);
	return Kick(playerid);
}

stock SCMError(playerid, str[])
{
	SCM(playerid, X_COLOUR_ERROR, str);
	return 1;
}

stock SCMInfo(playerid, str[])
{
	SCM(playerid, X_COLOUR_NOTIFICATION, str);
	return 1;
}
