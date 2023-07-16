#pragma library fry_config

// Конфигурация сервера
#define SERVER_NAME "FryTech Role Play"
#define SERVER_GREETING "Добро пожаловать на FryTech Role Play!"
#define EXP_PER_PAYDAY (2)
#define GMT (6) // Часовой пояс

// Настройка админ-функций
#define CMD_MAPTP_ALVL 2
#define CMD_PAYDAY_ALVL 4
#define CMD_SETLVL_ALVL 4
#define CMD_SPAWN_ALVL 4
#define CMD_SETMONEY_ALVL 4
#define CMD_GIVEMONEY_ALVL 4
#define CMD_REMOVEMONEY_ALVL 4
#define CMD_SETHP_ALVL 4
#define CMD_SETARM_ALVL 4
#define CMD_MAKEADMIN_ALVL 4
#define CMD_FIREADMIN_ALVL 4
#define CMD_KICK_ALVL 4
#define CMD_BANIP_ALVL 4
#define CMD_UNBANIP_ALVL 4
#define CMD_BAN_ALVL 4
#define CMD_UNBAN_ALVL 4
#define CMD_GOTO_ALVL 4
#define CMD_GOBACK_ALVL 4
#define CMD_GETHERE_ALVL 4
#define CMD_GETBACK_ALVL 4
#define CMD_SLAP_ALVL 4
#define CMD_RE_ALVL 4
#define CMD_REOFF_ALVL 4

// Ограничения
#define CHAT_RADIUS (30.0)
#define CHATBUBBLE_RADIUS (20.0)
#define MAX_CHAT_STR (144) + 64 // запас для цветов в чате
#define MAX_CHAT_MSG (80)
#define MAX_MAIL (64)
#define MAX_AFK_TIME (300)
#define MIN_PAYDAY_TIME (20)
