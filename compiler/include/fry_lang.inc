#pragma library fry_lang

// --------------------------------------------------- �������� --------------------------------------------------- //
#define BIG_TEXT_MSG "������� ������� �����"
#define UNKNOWN_CMD_MSG "[������] {FFFFFF}������� �� �������! �������� /help ��� ��������� ������ ��������� ������."
#define SHOW_MOUSE_MSG "[�����������] {FFFFFF}�� �������� ������. ����� ������ ��� ������� ������ ESC."
// --------------------------------------------------- ����� --------------------------------------------------- //
#define PLAYER_CHAT_MSG "%s[%d] �������: {B7AFAF}%s"
// --------------------------------------------------- ����� --------------------------------------------------- //
#define ADMIN_MAP_TP_MSG "[�����������] {FFFFFF}�� ���� ��������������� �� �����!"
// --------------------------------------------------- ������� PAYDAY --------------------------------------------------- //
#define PAYDAY_START_MSG "__________���������� ���__________"
#define PAYDAY_NEWLVL_MSG "�����������! ��� ����� �������: %d"
#define PAYDAY_LVL_MSG "��� ������� �������: %d"
#define PAYDAY_EXP_MSG "�� ��������� %d � ����� ��������� [%d/%d]"
#define PAYDAY_FINAL_MSG "__________________________________"
#define PAYDAY_ERROR01_MSG "[������] {FFFFFF}��� ��������� PayDay �� ������ �������� ������� %d �����!"
#define PAYDAY_ERROR02_MSG "[������] {FFFFFF}��� ��������� PayDay �� ������ ����� �� ������!"
// --------------------------------------------------- ������� AFK --------------------------------------------------- //
#define AFK_SEC_STR "������: {"#COLOUR_NOTIFICATION"}( %d ���. )"
#define AFK_MIN_STR "������: {"#COLOUR_NOTIFICATION"}( %d:%02d )"
#define AFK_EATING_STR "������: {"#COLOUR_MARIA"}( 5:00+ )"
#define AFK_FINISH_MSG "�� ���� �� �����: %02d:%02d"
// --------------------------------------------------- ����� - ������� --------------------------------------------------- //
#define CMD_ERROR_LOW_ALVL_MSG "[������] {FFFFFF}��� ������� �������������� ������������ ��� ���������� ������ �������!"
#define CMD_ERROR_VALUE_NOT_ALLOWED_MSG "[������] {FFFFFF}����� �������� �����������!"
#define CMD_ERROR_PLAYER_NOT_FOUND_MSG "[������] {FFFFFF}����� �� ������!"
#define CMD_ERROR_SPECTATE01_MSG "[������] {FFFFFF}������� ������� �� ������ ������ - /reoff"
#define CMD_ERROR_SPECTATE02_MSG "[������] {FFFFFF}���� ����� ������ �� ���-��!"

#define CMD_A_ERROR01_MSG "[������] {FFFFFF}��������� /a [���������]"
#define CMD_A_SUCCESS01_MSG "[A] %s[%d]: {FFFFFF}%s"

#define CMD_PAYDAY_ERROR01_MSG "[������] {FFFFFF}��������� /payday [���-��]"
#define CMD_PAYDAY_ERROR02_MSG "[������] {FFFFFF}�� ��� ����� ������� �� 4� PayDay!"
#define CMD_PAYDAY_SUCCESS01_MSG "[A] %s[%d] ������ PayDay %d ���(�)"

#define CMD_SETLVL_ERROR01_MSG "[������] {FFFFFF}��������� /setlvl [id] [�������]"
#define CMD_SETLVL_SUCCESS01_MSG "[A] %s[%d] ������� ������� ������ %s[%d] � %d �� %d"
#define CMD_SETLVL_SUCCESS02_MSG "[�����������] {FFFFFF}������������� %s[%d] ������� ��� ������� � {"#COLOUR_SRED"}%d{FFFFFF} �� {"#COLOUR_SRED"}%d{FFFFFF}!"

#define CMD_SPAWN_ERROR01_MSG "[������] {FFFFFF}��������� /spawn [id]"
#define CMD_SPAWN_SUCCESS01_MSG "[A] %s[%d] ��������� ������ %s[%d]"
#define CMD_SPAWN_SUCCESS02_MSG "[�����������] {FFFFFF}������������� %s[%d] ��������� ���."

#define CMD_SETMONEY_ERROR01_MSG "[������] {FFFFFF}��������� /setmoney [id] [���-��]"
#define CMD_SETMONEY_SUCCESS01_MSG "[A] %s[%d] ������� ���-�� �������� ������ %s[%d] � $%d �� $%d"
#define CMD_SETMONEY_SUCCESS02_MSG "[�����������] {FFFFFF}������������� %s[%d] ������� ���-�� ����� �������� �� {"#COLOUR_SRED"}$%d{FFFFFF}."

#define CMD_GIVEMONEY_ERROR01_MSG "[������] {FFFFFF}��������� /givemoney [id] [���-��]"
#define CMD_GIVEMONEY_ERROR02_MSG "[������] {FFFFFF}� ������ �������� �����!"
#define CMD_GIVEMONEY_SUCCESS01_MSG "[A] %s[%d] ����� ������ %s[%d] $%d ��������"
#define CMD_GIVEMONEY_SUCCESS02_MSG "[�����������] {FFFFFF}������������� %s[%d] ����� ��� {"#COLOUR_SRED"}$%d{FFFFFF} ��������."

#define CMD_REMOVEMONEY_ERROR01_MSG "[������] {FFFFFF}��������� /removemoney [id] [���-��]"
#define CMD_REMOVEMONEY_ERROR02_MSG "[������] {FFFFFF}� ����� ������ ��� ������� �����!"
#define CMD_REMOVEMONEY_SUCCESS01_MSG "[A] %s[%d] ������ � ������ %s[%d] $%d ��������"
#define CMD_REMOVEMONEY_SUCCESS02_MSG "[�����������] {FFFFFF}������������� %s[%d] ������ � ��� {"#COLOUR_SRED"}$%d{FFFFFF} ��������."

#define CMD_SETHP_ERROR01_MSG "[������] {FFFFFF}��������� /sethp [id] [���-��]"
#define CMD_SETHP_SUCCESS01_MSG "[A] %s[%d] ������� HP ������ %s[%d] �� %d"
#define CMD_SETHP_SUCCESS02_MSG "[�����������] {FFFFFF}������������� %s[%d] ������� ������� ������ �������� �� {"#COLOUR_SRED"}%d{FFFFFF}."

#define CMD_SETARM_ERROR01_MSG "[������] {FFFFFF}��������� /setarm [id] [���-��]"
#define CMD_SETARM_SUCCESS01_MSG "[A] %s[%d] ������� ARM ������ %s[%d] �� %d"
#define CMD_SETARM_SUCCESS02_MSG "[�����������] {FFFFFF}������������� %s[%d] ������� ������� ����� ����� �� {"#COLOUR_SRED"}%d{FFFFFF}."

#define CMD_MAKEADMIN_ERROR01_MSG "[������] {FFFFFF}��������� /makeadmin [id] [�������]"
#define CMD_MAKEADMIN_ERROR02_MSG "[������] {FFFFFF}�� �� ������ ��������� ��������������� ������ ����!"
#define CMD_MAKEADMIN_SUCCESS01_MSG "[A] %s[%d] �������� ������ %s[%d] ��������������� %d�� ������!"
#define CMD_MAKEADMIN_SUCCESS02_MSG "[�����������] {FFFFFF}%s[%d] �������� ��� ��������������� {"#COLOUR_SRED"}%d{FFFFFF} ������! �����������!"

#define CMD_FIREADMIN_ERROR01_MSG  "[������] {FFFFFF}��������� /fireadmin [id]"
#define CMD_FIREADMIN_ERROR02_MSG "[������] {FFFFFF}�� �� ������ ����� ���� � ����� ��������������!"
#define CMD_FIREADMIN_ERROR03_MSG "[������] {FFFFFF}���� ����� �� �������� ���������������!"
#define CMD_FIREADMIN_SUCCESS01_MSG "[A] %s[%d] ���� ������ %s[%d] � ����� ��������������"
#define CMD_FIREADMIN_SUCCESS02_MSG "[�����������] {FFFFFF}%s[%d] ���� ��� � ����� ��������������"

#define CMD_KICK_ERROR01_MSG  "[������] {FFFFFF}��������� /kick [id] [�������]"
#define CMD_KICK_ERROR02_MSG "[������] {FFFFFF}�� �� ������ ������� ������ ����!"
#define CMD_KICK_SUCCESS01_MSG "[�����������] {FFFFFF}�� ���� ������� � �������. �����������."
#define CMD_KICK_SUCCESS02_MSG "������������� %s[%d] ������ ������ %s[%d]. �������: %s"
#define DLG_KICK_HEADER "{"#COLOUR_SRED"}��� � �������"
#define DLG_KICK_STR "\
{FFFFFF}������������� {"#COLOUR_NOTIFICATION"}%s{FFFFFF} ������ ��� � �������.\
\n\
�������: %s\
\n\
{"#COLOUR_LGREEN"}���� �� �� �������� � �������� �������������� - �������� ������ �� ������."

#define CMD_BANIP_ERROR01_MSG "[������] {FFFFFF}��������� /banip [id] [�������]"
#define CMD_BANIP_ERROR02_MSG "[������] {FFFFFF}�� �� ������ ������������� ���� IP!"
#define CMD_BANIP_SUCCESS01_MSG "[�����������] {FFFFFF}��� IP ��� ������������ �� ����� �������!"
#define CMD_BANIP_SUCCESS02_MSG "������������� %s[%d] ������� �� IP ������ %s[%d]. �������: %s"
#define DLG_BANIP_HEADER "{"#COLOUR_SRED"}���������� �� IP"
#define DLG_BANIP_STR "\
{FFFFFF}������������� {"#COLOUR_NOTIFICATION"}%s{FFFFFF} ������������ ��� IP.\
\n\
�������: %s\
\n\
{"#COLOUR_LGREEN"}���� �� �� �������� � �������� �������������� - �������� ������ �� ������."

#define CMD_UNBANIP_ERROR01_MSG "[������] {FFFFFF}��������� /unbanip [��� ��� IP]"
#define CMD_UNBANIP_ERROR02_MSG "[������] {FFFFFF}�� ������� ������ �� �������!"
#define CMD_UNBANIP_SUCCESS01_MSG "[A] %s[%d] ������������� IP %s"
#define DLG_UNBANIP_HEADER "{"#COLOUR_SRED"}������������� IP"
#define DLG_UNBANIP_STR "\n\
{FFFFFF}�����: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}IP: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}���� ����������: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}������������: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}�������: {"#COLOUR_NOTIFICATION"}%s\n\
\n\
{"#COLOUR_LGREEN"}�� �������, ��� ������ ��������� ���� IP?"

#define CMD_BAN_ERROR01_MSG "[������] {FFFFFF}��������� /ban [id] [���] [�������]"
#define CMD_BAN_ERROR02_MSG "[������] {FFFFFF}�� �� ������ ������������� ����!"
#define CMD_BAN_ERROR03_MSG "[������] {FFFFFF}���-�� ����: �� 1 �� 7000"
#define CMD_BAN_SUCCESS01_MSG "[�����������] {FFFFFF}��� ������� ��� ������������ �� ����� �������!"
#define CMD_BAN_SUCCESS02_MSG "������������� %s[%d] ������� ������ %s[%d] �� %d ����. �������: %s"
#define DLG_BAN_HEADER "{"#COLOUR_SRED"}���������� ��������"
#define DLG_BAN_STR "\n\
{FFFFFF}������������� {"#COLOUR_NOTIFICATION"}%s{FFFFFF} ������������ ��� �������.\n\
���� �������: %s\n\
�������: %s\n\
{"#COLOUR_LGREEN"}���� �� �� �������� � �������� �������������� - �������� ������ �� ������."

#define CMD_UNBAN_ERROR01_MSG "[������] {FFFFFF}��������� /unban [���]"
#define CMD_UNBAN_ERROR02_MSG "[������] {FFFFFF}������ ������� �� ������������!"
#define CMD_UNBAN_SUCCESS01_MSG "[A] %s[%d] �������� ������ %s"
#define DLG_UNBAN_HEADER "{"#COLOUR_SRED"}������������� ��������"
#define DLG_UNBAN_STR "\n\
{FFFFFF}�����: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}IP: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}���� ����������: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}���� �������: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}������������: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}�������: {"#COLOUR_NOTIFICATION"}%s\n\
\n\
{"#COLOUR_LGREEN"}�� �������, ��� ������ ��������� ���� �������?"

#define CMD_GOTO_ERROR01_MSG "[������] {FFFFFF}��������� /goto [id]"
#define CMD_GOTO_ERROR02_MSG "[������] {FFFFFF}�� �� ������ ����������������� ���� � ����!"
#define CMD_GOTO_SUCCESS01_MSG "[���������] {FFFFFF}����������� /goback ����� ����������������� �������"

#define CMD_GETHERE_ERROR01_MSG "[������] {FFFFFF}��������� /gethere [id]"
#define CMD_GETHERE_ERROR02_MSG "[������] {FFFFFF}�� �� ������ ��������������� ���� � ����!"
#define CMD_GETHERE_SUCCESS01_MSG "[���������] {FFFFFF}����������� /getback [%d] ����� ��������������� ������ �������"
#define CMD_GETHERE_SUCCESS02_MSG "[�����������] {FFFFFF}������������� %s[%d] �������������� ��� � ����."

#define CMD_GOBACK_ERROR01_MSG "[������] {FFFFFF}��� ������ ���������� :)"
#define CMD_GOBACK_SUCCESS01_MSG "[�����������] {FFFFFF}�� ������� ��������� �� ������� �������!"

#define CMD_GETBACK_ERROR01_MSG "[������] {FFFFFF}��������� /getback [id]"
#define CMD_GETBACK_ERROR02_MSG "[������] {FFFFFF}����������� /goback ����� ������� ����!"
#define CMD_GETBACK_ERROR03_MSG "[������] {FFFFFF}�� �� ������ ������� ������, �������� �� ���������������!"
#define CMD_GETBACK_SUCCESS01_MSG "[�����������] {FFFFFF}������������� %s[%d] ������ ��� ����, ��� �� ����."

#define CMD_SLAP_ERROR01_MSG "[������] {FFFFFF}��������� /slap [id]"
#define CMD_SLAP_ERROR02_MSG "[������] {FFFFFF}����� ��� ������ ��������� ����?"
#define CMD_SLAP_SUCCESS01_MSG  "[A] %s[%d] ��� ��������� ������ %s[%d]"
#define CMD_SLAP_SUCCESS02_MSG "[�����������] {FFFFFF}������������� %s[%d] ��� ��� ���������"

#define CMD_RE_ERROR01_MSG "[������] {FFFFFF}��������� /re [id]"
#define CMD_RE_ERROR02_MSG "[������] {FFFFFF}��� �� ����������� ������� �� �����?"
#define CMD_RE_SUCCESS01_MSG  "[A] %s[%d] ����� ������� �� ������� %s[%d]"

#define CMD_REOFF_ERROR01_MSG "[������] {FFFFFF}�� �� �� ��� �� �������!"
// --------------------------------------------------- ������� ������� --------------------------------------------------- //
#define CMD_ME_ERROR01_MSG "[������] {FFFFFF}��������� /me [��������]"

#define CMD_DO_ERROR01_MSG "[������] {FFFFFF}��������� /do [�������� �� 3�� ����]"

#define CMD_TRY_ERROR01_MSG "[������] {FFFFFF}��������� /try [��������]"
#define CMD_TRY_SUCCESS_STR "������"
#define CMD_TRY_SUCCESS_MSG "%s %s | {"#COLOUR_LGREEN"}������"
#define CMD_TRY_FAIL_STR "��������"
#define CMD_TRY_FAIL_MSG "%s %s | {"#COLOUR_RED"}��������"

#define CMD_TODO_ERROR01_MSG "[������] {FFFFFF}��������� /todo [�����*��������]"
#define CMD_TODO_SUCCESS01_MSG "\"%s\", - ������ %s,{"#COLOUR_ME"} %s."

#define CMD_N_ERROR01_MSG "[������] {FFFFFF}��������� /n [�����]"
#define CMD_N_SUCCESS01_MSG "%s[%d] (( {"#COLOUR_GREY"}%s{FFFFFF} ))"

#define CMD_S_ERROR01_MSG "[������] {FFFFFF}��������� /s [�����]"
#define CMD_S_SUCCESS01_MSG "%s[%d] ������: {FFFFFF}%s!!"

#define CMD_C_ERROR01_MSG "[������] {FFFFFF}��������� /c [�����]"
#define CMD_C_SUCCESS01_MSG "%s[%d] ���������: {FFFFFF}%s"
// --------------------------------------------------- ������� --------------------------------------------------- //
#define DLG_NEXT "�����"
#define DLG_SELECT "�������"
#define DLG_YES "��"
#define DLG_CANCEL "������"
#define DLG_BACK "�����"
#define DLG_SKIP "�������"
#define DLG_EXIT "�����"
#define DLG_CLOSE "�������"
#define DLG_EXIT_SERVER "[���������] {FFFFFF}����������� \"/q\" ��� ������ �� ����."
#define DLG_TIME_OVER_MSG "[�����������]{FFFFFF} �� ���� ������� �� �����������. �����������."
// --------------------------------------------------- ������ ��� ���� IP --------------------------------------------------- //
#define DLG_BANNEDIP_HEADER "{"#COLOUR_SRED"}��� IP ������������ �� ����� �������!"
#define DLG_BANNEDIP_STR "\n\
{FFFFFF}���� ����������: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}������������: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}�������: {"#COLOUR_NOTIFICATION"}%s\n\
\n\
{"#COLOUR_LGREEN"}���� �� �� �������� � �������� �������������� - �������� ������ �� ������."
// --------------------------------------------------- ������ ��� ���� --------------------------------------------------- //
#define DLG_BANNED_HEADER "{"#COLOUR_SRED"}��� ������� ������������ �� ����� �������!"
#define DLG_BANNED_STR "\n\
{FFFFFF}���� ����������: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}���� �������: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}������������: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}�������: {"#COLOUR_NOTIFICATION"}%s\n\
\n\
{"#COLOUR_LGREEN"}���� �� �� �������� � �������� �������������� - �������� ������ �� ������."
// --------------------------------------------------- ������ ����������� --------------------------------------------------- //
#define DLG_REG_PASSWORD_HEADER "{"#COLOUR_NOTIFICATION"}[1/4] ������"
#define DLG_REG_PASSWORD_STR "\n\
{FFFFFF}����� ����������, {"#COLOUR_NOTIFICATION"}%s{FFFFFF}!\n\
������ ������� {"#COLOUR_LGREEN"}�� ���������������{FFFFFF} �� ����� �������.\n\
��� ������ ���� �� ����� ������� �� ������ ������ �����������.\n\n\
���������� �������� ������ ��� ������ �������� � ������� \"�����\".\n\
\t{E32636}� ������ ������ ����� ����� �� 8 �� 32 ��������\n\
\t{E32636}� ������ ������ �������� ������ �� ���� � ����\n\
\t{E32636}� ������ ������������ � ��������"
#define DLG_REG_SEX_HEADER "{"#COLOUR_NOTIFICATION"}[2/4] ���"
#define DLG_REG_SEX_LIST "�������\n�������"
#define DLG_REG_RACE_HEADER "{"#COLOUR_NOTIFICATION"}[3/4] ����"
#define DLG_REG_RACE_LIST "��������\n��������������\n�����"
#define DLG_REG_REFERAL_HEADER "{"#COLOUR_NOTIFICATION"}[4/4] �������"
#define DLG_REG_REFERAL_STR "\n{FFFFFF}��� ������, ������������� ��� �� ������\n������: {"#COLOUR_NOTIFICATION"}Olaf_Tormund"
#define DLG_REG_SUCCESS_MSG "[�����������] {FFFFFF}����������� ����� ���������! �������� ������� ������."
#define DLG_REG_EMPTY_MSG "[������] {FFFFFF}�� ������ �� �����!"
#define DLG_REG_NOT_ALLOWED_PASS01_MSG "[������] {FFFFFF}������ ������ ����� ����� �� 8 �� 32 ��������!"
#define DLG_REG_NOT_ALLOWED_PASS02_MSG "[������] {FFFFFF}������ ������ �������� �� ���� � ����!"
#define DLG_REG_REFERAL_NOT_FOUND01_MSG "[������]{FFFFFF} ����� � ����� ����� �� ������! �������� �������: %i"
#define DLG_REG_REFERAL_NOT_FOUND02_MSG "[���������] {FFFFFF}���� ��� ����� �� ���������, �� �������� ���� ������ ��� ������� \"�������\"."
#define DLG_REG_REFERAL_KICK_MSG "[�����������]{FFFFFF} �� ���� ������� �.�. 3 ���� ����� �������� ���. �����������."
// --------------------------------------------------- ������ ����������� --------------------------------------------------- //
#define DLG_LOGIN_PASSWORD_HEADER "{"#COLOUR_NOTIFICATION"}�����������"
#define DLG_LOGIN_PASSWORD_STR "\n\
{FFFFFF}����� ����������, {"#COLOUR_NOTIFICATION"}%s{FFFFFF}!\n\
������� ��� ������.\n\
\n\
������� ��� ����� ������: {"#COLOUR_LGREEN"}%d{FFFFFF}"
#define DLG_LOGIN_SUCCESS_MSG "[�����������] {FFFFFF}�� ������� �����!"
#define DLG_LOGIN_PASSWORD_WRONG_STR "\n\
{FFFFFF}����� ����������, {E88813}%s{FFFFFF}!\n\
\n\
{"#COLOUR_ERROR"}�������� ������!{FFFFFF}\n\
������� ��� ����� ������: {"#COLOUR_ERROR"}%d{FFFFFF}"
#define DLG_LOGIN_PASSWORD_WRONG_MSG "[�����������]{FFFFFF} �� ���� ������� �.�. 3 ���� ����� �������� ������!"
// --------------------------------------------------- ������ ���� --------------------------------------------------- //
#define DLG_MENU01_HEADER "{"#COLOUR_NOTIFICATION"}���� ������"
#define DLG_MENU01_LIST "\n\
{"#COLOUR_SRED"}[1] {FFFFFF}��������� ���������\n\
{"#COLOUR_SRED"}[2] {FFFFFF}������ ���������\n\
{"#COLOUR_SRED"}[3] {FFFFFF}��������� � ��������������\n\
{"#COLOUR_SRED"}[4] {FFFFFF}��������� ��������\n\
{"#COLOUR_SRED"}[5] {FFFFFF}������/������ ������\n\
{"#COLOUR_SRED"}[6] {FFFFFF}�����\n"

#define DLG_MENU02_HEADER "{"#COLOUR_NOTIFICATION"}��������� ���������"
#define DLG_MENU02_LIST "\n\
{"#COLOUR_SRED"}[1] {FFFFFF}��� ����������\n\
{"#COLOUR_SRED"}[2] {FFFFFF}���� ����������\n\
{"#COLOUR_SRED"}[3] {FFFFFF}���� ����\n\
{"#COLOUR_SRED"}[4] {FFFFFF}���� ������\n\
{"#COLOUR_SRED"}[5] {FFFFFF}���� �����\n\
{"#COLOUR_SRED"}[6] {FFFFFF}��� ��������\n\
{"#COLOUR_SRED"}[7] {FFFFFF}��� �������\n\
{"#COLOUR_SRED"}[8] {FFFFFF}�������� �������\n\
{"#COLOUR_SRED"}[9] {FFFFFF}������� Non-RP ���"

#define DLG_MENU03_HEADER "{"#COLOUR_NOTIFICATION"}������ ���������"
#define DLG_MENU03_LIST "\n\
{"#COLOUR_SRED"}[1] {FFFFFF}����� ��������\n\
{"#COLOUR_SRED"}[2] {FFFFFF}����� ����������� ���\n\
{"#COLOUR_SRED"}[3] {FFFFFF}����� ��������\n\
{"#COLOUR_SRED"}[4] {FFFFFF}����� �������������\n\
{"#COLOUR_SRED"}[5] {FFFFFF}����� �������\n\
{"#COLOUR_SRED"}[6] {FFFFFF}����� ��������\n\
{"#COLOUR_SRED"}[7] {FFFFFF}����� ���������� ����������\n\
{"#COLOUR_SRED"}[8] {FFFFFF}����� �������������"

#define DLG_NONRP_NAME_HEADER "{"#COLOUR_NOTIFICATION"}����� Non-RP ����"
#define DLG_NONRP_NAME_STR "������� ���� ����� RP ���:\n������: {"#COLOUR_NOTIFICATION"}Paul_McCartney"
#define DLG_NONRP_NAME_SUCCESS01_MSG "[�����������] ������ �� ����� ���� ����������. �������� ������������� �������������."

#define DLG_STATS01_HEADER "{"#COLOUR_NOTIFICATION"}���������� ���������"
#define DLG_STATS01_STR "\n\
{FFFFFF}���: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}���: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}����: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}�������: {"#COLOUR_NOTIFICATION"}%d\n\
{FFFFFF}���������: {"#COLOUR_NOTIFICATION"}[%d/%d]\n\
\n\
{FFFFFF}�������� ������: {"#COLOUR_NOTIFICATION"}$%d\n\
{FFFFFF}������ � �����: {"#COLOUR_NOTIFICATION"}$%d\n\
{FFFFFF}������ �� ��������: {"#COLOUR_NOTIFICATION"}$%d\n\
\n\
{FFFFFF}������: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}�����������: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}�����������������: {"#COLOUR_NOTIFICATION"}[%d/100]\n\
{FFFFFF}������� �������: {"#COLOUR_NOTIFICATION"}%d\n\
\n\
{FFFFFF}����� ��������: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}����� ����������� �����: {"#COLOUR_NOTIFICATION"}%s\n\
\n\
{FFFFFF}������� ������: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}������ �� �����: {"#COLOUR_NOTIFICATION"}%d ���.\n\
{FFFFFF}��������������: {"#COLOUR_NOTIFICATION"}[%d/3]"
// --------------------------------------------------- �������� --------------------------------------------------- //
#define AC_AIRBREAK_VEHICLE_MSG "[AntiCheat]{FFFFFF} %s[%d] ��� ������ �� AirBreak [ByVehicle] [Ping:%d]"
#define AC_AIRBREAK_FOOT_MSG "[AntiCheat]{FFFFFF} %s[%d] ��� ������ �� AirBreak [ByFoot] [Ping:%d]"

#define AC_KICK_MSG "�� ���� ������� �� ���������� � ���������!"
