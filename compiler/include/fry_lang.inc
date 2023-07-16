#pragma library fry_lang

// --------------------------------------------------- ОСНОВНОЕ --------------------------------------------------- //
#define BIG_TEXT_MSG "Слишком длинный текст"
#define UNKNOWN_CMD_MSG "[Ошибка] {FFFFFF}Команда не найдена! Напишите /help для получения списка доступных команд."
#define SHOW_MOUSE_MSG "[Уведомление] {FFFFFF}Вы включили курсор. Чтобы скрыть его нажмите кнопку ESC."
// --------------------------------------------------- ИГРОК --------------------------------------------------- //
#define PLAYER_CHAT_MSG "%s[%d] говорит: {B7AFAF}%s"
// --------------------------------------------------- АДМИН --------------------------------------------------- //
#define ADMIN_MAP_TP_MSG "[Уведомление] {FFFFFF}Вы были телепортированы на метку!"
// --------------------------------------------------- Система PAYDAY --------------------------------------------------- //
#define PAYDAY_START_MSG "__________Банковский чек__________"
#define PAYDAY_NEWLVL_MSG "Поздравляем! Ваш новый уровень: %d"
#define PAYDAY_LVL_MSG "Ваш текущий уровень: %d"
#define PAYDAY_EXP_MSG "Вы получаете %d к очкам репутации [%d/%d]"
#define PAYDAY_FINAL_MSG "__________________________________"
#define PAYDAY_ERROR01_MSG "[Ошибка] {FFFFFF}Для получения PayDay вы должны отыграть минимум %d минут!"
#define PAYDAY_ERROR02_MSG "[Ошибка] {FFFFFF}Для получения PayDay вы должны войти на сервер!"
// --------------------------------------------------- Система AFK --------------------------------------------------- //
#define AFK_SEC_STR "Отошел: {"#COLOUR_NOTIFICATION"}( %d сек. )"
#define AFK_MIN_STR "Отошел: {"#COLOUR_NOTIFICATION"}( %d:%02d )"
#define AFK_EATING_STR "Кушает: {"#COLOUR_MARIA"}( 5:00+ )"
#define AFK_FINISH_MSG "Вы были на паузе: %02d:%02d"
// --------------------------------------------------- АДМИН - КОМАНДЫ --------------------------------------------------- //
#define CMD_ERROR_LOW_ALVL_MSG "[Ошибка] {FFFFFF}Ваш уровень администратора недостаточен для выполнения данной команды!"
#define CMD_ERROR_VALUE_NOT_ALLOWED_MSG "[Ошибка] {FFFFFF}Такое значение недопустимо!"
#define CMD_ERROR_PLAYER_NOT_FOUND_MSG "[Ошибка] {FFFFFF}Игрок не найден!"
#define CMD_ERROR_SPECTATE01_MSG "[Ошибка] {FFFFFF}Сначала выйдите из режима слежки - /reoff"
#define CMD_ERROR_SPECTATE02_MSG "[Ошибка] {FFFFFF}Этот игрок следит за кем-то!"

#define CMD_A_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /a [сообщение]"
#define CMD_A_SUCCESS01_MSG "[A] %s[%d]: {FFFFFF}%s"

#define CMD_PAYDAY_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /payday [кол-во]"
#define CMD_PAYDAY_ERROR02_MSG "[Ошибка] {FFFFFF}За раз можно вызвать до 4х PayDay!"
#define CMD_PAYDAY_SUCCESS01_MSG "[A] %s[%d] вызвал PayDay %d раз(а)"

#define CMD_SETLVL_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /setlvl [id] [уровень]"
#define CMD_SETLVL_SUCCESS01_MSG "[A] %s[%d] изменил уровень игрока %s[%d] с %d на %d"
#define CMD_SETLVL_SUCCESS02_MSG "[Уведомление] {FFFFFF}Администратор %s[%d] изменил ваш уровень с {"#COLOUR_SRED"}%d{FFFFFF} на {"#COLOUR_SRED"}%d{FFFFFF}!"

#define CMD_SPAWN_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /spawn [id]"
#define CMD_SPAWN_SUCCESS01_MSG "[A] %s[%d] заспавнил игрока %s[%d]"
#define CMD_SPAWN_SUCCESS02_MSG "[Уведомление] {FFFFFF}Администратор %s[%d] заспавнил вас."

#define CMD_SETMONEY_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /setmoney [id] [кол-во]"
#define CMD_SETMONEY_SUCCESS01_MSG "[A] %s[%d] изменил кол-во наличных игрока %s[%d] с $%d на $%d"
#define CMD_SETMONEY_SUCCESS02_MSG "[Уведомление] {FFFFFF}Администратор %s[%d] изменил кол-во ваших наличных на {"#COLOUR_SRED"}$%d{FFFFFF}."

#define CMD_GIVEMONEY_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /givemoney [id] [кол-во]"
#define CMD_GIVEMONEY_ERROR02_MSG "[Ошибка] {FFFFFF}У игрока максимум денег!"
#define CMD_GIVEMONEY_SUCCESS01_MSG "[A] %s[%d] выдал игроку %s[%d] $%d наличных"
#define CMD_GIVEMONEY_SUCCESS02_MSG "[Уведомление] {FFFFFF}Администратор %s[%d] выдал вам {"#COLOUR_SRED"}$%d{FFFFFF} наличных."

#define CMD_REMOVEMONEY_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /removemoney [id] [кол-во]"
#define CMD_REMOVEMONEY_ERROR02_MSG "[Ошибка] {FFFFFF}У этого игрока нет столько денег!"
#define CMD_REMOVEMONEY_SUCCESS01_MSG "[A] %s[%d] забрал у игрока %s[%d] $%d наличных"
#define CMD_REMOVEMONEY_SUCCESS02_MSG "[Уведомление] {FFFFFF}Администратор %s[%d] забрал у вас {"#COLOUR_SRED"}$%d{FFFFFF} наличных."

#define CMD_SETHP_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /sethp [id] [кол-во]"
#define CMD_SETHP_SUCCESS01_MSG "[A] %s[%d] изменил HP игрока %s[%d] на %d"
#define CMD_SETHP_SUCCESS02_MSG "[Уведомление] {FFFFFF}Администратор %s[%d] изменил уровень вашего здоровья на {"#COLOUR_SRED"}%d{FFFFFF}."

#define CMD_SETARM_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /setarm [id] [кол-во]"
#define CMD_SETARM_SUCCESS01_MSG "[A] %s[%d] изменил ARM игрока %s[%d] на %d"
#define CMD_SETARM_SUCCESS02_MSG "[Уведомление] {FFFFFF}Администратор %s[%d] изменил уровень вашей брони на {"#COLOUR_SRED"}%d{FFFFFF}."

#define CMD_MAKEADMIN_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /makeadmin [id] [уровень]"
#define CMD_MAKEADMIN_ERROR02_MSG "[Ошибка] {FFFFFF}Вы не можете назначить администратором самого себя!"
#define CMD_MAKEADMIN_SUCCESS01_MSG "[A] %s[%d] назначил игрока %s[%d] администратором %dго уровня!"
#define CMD_MAKEADMIN_SUCCESS02_MSG "[Уведомление] {FFFFFF}%s[%d] назначил вас администратором {"#COLOUR_SRED"}%d{FFFFFF} уровня! Поздравляем!"

#define CMD_FIREADMIN_ERROR01_MSG  "[Ошибка] {FFFFFF}Используй /fireadmin [id]"
#define CMD_FIREADMIN_ERROR02_MSG "[Ошибка] {FFFFFF}Вы не можете снять себя с поста администратора!"
#define CMD_FIREADMIN_ERROR03_MSG "[Ошибка] {FFFFFF}Этот игрок не является администратором!"
#define CMD_FIREADMIN_SUCCESS01_MSG "[A] %s[%d] снял игрока %s[%d] с поста администратора"
#define CMD_FIREADMIN_SUCCESS02_MSG "[Уведомление] {FFFFFF}%s[%d] снял вас с поста администратора"

#define CMD_KICK_ERROR01_MSG  "[Ошибка] {FFFFFF}Используй /kick [id] [причина]"
#define CMD_KICK_ERROR02_MSG "[Ошибка] {FFFFFF}Вы не можете кикнуть самого себя!"
#define CMD_KICK_SUCCESS01_MSG "[Уведомление] {FFFFFF}Вы были кикнуты с сервера. Перезайдите."
#define CMD_KICK_SUCCESS02_MSG "Администратор %s[%d] кикнул игрока %s[%d]. Причина: %s"
#define DLG_KICK_HEADER "{"#COLOUR_SRED"}Кик с сервера"
#define DLG_KICK_STR "\
{FFFFFF}Администратор {"#COLOUR_NOTIFICATION"}%s{FFFFFF} кикнул вас с сервера.\
\n\
Причина: %s\
\n\
{"#COLOUR_LGREEN"}Если вы не согласны с решением администратора - оставьте жалобу на форуме."

#define CMD_BANIP_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /banip [id] [причина]"
#define CMD_BANIP_ERROR02_MSG "[Ошибка] {FFFFFF}Вы не можете заблокировать свой IP!"
#define CMD_BANIP_SUCCESS01_MSG "[Уведомление] {FFFFFF}Ваш IP был заблокирован на нашем сервере!"
#define CMD_BANIP_SUCCESS02_MSG "Администратор %s[%d] забанил по IP игрока %s[%d]. Причина: %s"
#define DLG_BANIP_HEADER "{"#COLOUR_SRED"}Блокировка по IP"
#define DLG_BANIP_STR "\
{FFFFFF}Администратор {"#COLOUR_NOTIFICATION"}%s{FFFFFF} заблокировал ваш IP.\
\n\
Причина: %s\
\n\
{"#COLOUR_LGREEN"}Если вы не согласны с решением администратора - оставьте жалобу на форуме."

#define CMD_UNBANIP_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /unbanip [ник или IP]"
#define CMD_UNBANIP_ERROR02_MSG "[Ошибка] {FFFFFF}По запросу ничего не найдено!"
#define CMD_UNBANIP_SUCCESS01_MSG "[A] %s[%d] разблокировал IP %s"
#define DLG_UNBANIP_HEADER "{"#COLOUR_SRED"}Разблокировка IP"
#define DLG_UNBANIP_STR "\n\
{FFFFFF}Игрок: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}IP: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Дата блокировки: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Заблокировал: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Причина: {"#COLOUR_NOTIFICATION"}%s\n\
\n\
{"#COLOUR_LGREEN"}Вы уверены, что хотите разбанить этот IP?"

#define CMD_BAN_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /ban [id] [дни] [причина]"
#define CMD_BAN_ERROR02_MSG "[Ошибка] {FFFFFF}Вы не можете заблокировать себя!"
#define CMD_BAN_ERROR03_MSG "[Ошибка] {FFFFFF}Кол-во дней: от 1 до 7000"
#define CMD_BAN_SUCCESS01_MSG "[Уведомление] {FFFFFF}Ваш аккаунт был заблокирован на нашем сервере!"
#define CMD_BAN_SUCCESS02_MSG "Администратор %s[%d] забанил игрока %s[%d] на %d дней. Причина: %s"
#define DLG_BAN_HEADER "{"#COLOUR_SRED"}Блокировка аккаунта"
#define DLG_BAN_STR "\n\
{FFFFFF}Администратор {"#COLOUR_NOTIFICATION"}%s{FFFFFF} заблокировал ваш аккаунт.\n\
Дата разбана: %s\n\
Причина: %s\n\
{"#COLOUR_LGREEN"}Если вы не согласны с решением администратора - оставьте жалобу на форуме."

#define CMD_UNBAN_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /unban [ник]"
#define CMD_UNBAN_ERROR02_MSG "[Ошибка] {FFFFFF}Данный аккаунт не заблокирован!"
#define CMD_UNBAN_SUCCESS01_MSG "[A] %s[%d] разбанил игрока %s"
#define DLG_UNBAN_HEADER "{"#COLOUR_SRED"}Разблокировка аккаунта"
#define DLG_UNBAN_STR "\n\
{FFFFFF}Игрок: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}IP: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Дата блокировки: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Дата разбана: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Заблокировал: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Причина: {"#COLOUR_NOTIFICATION"}%s\n\
\n\
{"#COLOUR_LGREEN"}Вы уверены, что хотите разбанить этот аккаунт?"

#define CMD_GOTO_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /goto [id]"
#define CMD_GOTO_ERROR02_MSG "[Ошибка] {FFFFFF}Вы не можете телепортироваться сами к себе!"
#define CMD_GOTO_SUCCESS01_MSG "[Подсказка] {FFFFFF}Используйте /goback чтобы телепортироваться обратно"

#define CMD_GETHERE_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /gethere [id]"
#define CMD_GETHERE_ERROR02_MSG "[Ошибка] {FFFFFF}Вы не можете телепортировать себя к себе!"
#define CMD_GETHERE_SUCCESS01_MSG "[Подсказка] {FFFFFF}Используйте /getback [%d] чтобы телепортировать игрока обратно"
#define CMD_GETHERE_SUCCESS02_MSG "[Уведомление] {FFFFFF}Администратор %s[%d] телепортировал вас к себе."

#define CMD_GOBACK_ERROR01_MSG "[Ошибка] {FFFFFF}Вас некуда возвращать :)"
#define CMD_GOBACK_SUCCESS01_MSG "[Уведомление] {FFFFFF}Вы успешно вернулись на прошлую позицию!"

#define CMD_GETBACK_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /getback [id]"
#define CMD_GETBACK_ERROR02_MSG "[Ошибка] {FFFFFF}Используйте /goback чтобы вернуть себя!"
#define CMD_GETBACK_ERROR03_MSG "[Ошибка] {FFFFFF}Вы не можете вернуть игрока, которого не телепортировали!"
#define CMD_GETBACK_SUCCESS01_MSG "[Уведомление] {FFFFFF}Администратор %s[%d] вернул вас туда, где вы были."

#define CMD_SLAP_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /slap [id]"
#define CMD_SLAP_ERROR02_MSG "[Ошибка] {FFFFFF}Зачем вам давать поджопник себе?"
#define CMD_SLAP_SUCCESS01_MSG  "[A] %s[%d] дал поджопник игроку %s[%d]"
#define CMD_SLAP_SUCCESS02_MSG "[Уведомление] {FFFFFF}Администратор %s[%d] дал вам поджопник"

#define CMD_RE_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /re [id]"
#define CMD_RE_ERROR02_MSG "[Ошибка] {FFFFFF}Как вы собираетесь следить за собой?"
#define CMD_RE_SUCCESS01_MSG  "[A] %s[%d] начал следить за игроком %s[%d]"

#define CMD_REOFF_ERROR01_MSG "[Ошибка] {FFFFFF}Вы ни за кем не следите!"
// --------------------------------------------------- КОМАНДЫ ИГРОКОВ --------------------------------------------------- //
#define CMD_ME_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /me [действие]"

#define CMD_DO_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /do [действие от 3го лица]"

#define CMD_TRY_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /try [действие]"
#define CMD_TRY_SUCCESS_STR "Удачно"
#define CMD_TRY_SUCCESS_MSG "%s %s | {"#COLOUR_LGREEN"}Удачно"
#define CMD_TRY_FAIL_STR "Неудачно"
#define CMD_TRY_FAIL_MSG "%s %s | {"#COLOUR_RED"}Неудачно"

#define CMD_TODO_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /todo [фраза*действие]"
#define CMD_TODO_SUCCESS01_MSG "\"%s\", - сказал %s,{"#COLOUR_ME"} %s."

#define CMD_N_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /n [текст]"
#define CMD_N_SUCCESS01_MSG "%s[%d] (( {"#COLOUR_GREY"}%s{FFFFFF} ))"

#define CMD_S_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /s [текст]"
#define CMD_S_SUCCESS01_MSG "%s[%d] кричит: {FFFFFF}%s!!"

#define CMD_C_ERROR01_MSG "[Ошибка] {FFFFFF}Используй /c [текст]"
#define CMD_C_SUCCESS01_MSG "%s[%d] прошептал: {FFFFFF}%s"
// --------------------------------------------------- ДИАЛОГИ --------------------------------------------------- //
#define DLG_NEXT "Далее"
#define DLG_SELECT "Выбрать"
#define DLG_YES "Да"
#define DLG_CANCEL "Отмена"
#define DLG_BACK "Назад"
#define DLG_SKIP "Пропуск"
#define DLG_EXIT "Выход"
#define DLG_CLOSE "Закрыть"
#define DLG_EXIT_SERVER "[Подсказка] {FFFFFF}Используйте \"/q\" для выхода из игры."
#define DLG_TIME_OVER_MSG "[Уведомление]{FFFFFF} Вы были кикнуты за бездействие. Перезайдите."
// --------------------------------------------------- ДИАЛОГ ПРИ БАНЕ IP --------------------------------------------------- //
#define DLG_BANNEDIP_HEADER "{"#COLOUR_SRED"}Ваш IP заблокирован на нашем сервере!"
#define DLG_BANNEDIP_STR "\n\
{FFFFFF}Дата блокировки: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Заблокировал: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Причина: {"#COLOUR_NOTIFICATION"}%s\n\
\n\
{"#COLOUR_LGREEN"}Если вы не согласны с решением администратора - оставьте жалобу на форуме."
// --------------------------------------------------- ДИАЛОГ ПРИ БАНЕ --------------------------------------------------- //
#define DLG_BANNED_HEADER "{"#COLOUR_SRED"}Ваш аккаунт заблокирован на нашем сервере!"
#define DLG_BANNED_STR "\n\
{FFFFFF}Дата блокировки: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Дата разбана: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Заблокировал: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Причина: {"#COLOUR_NOTIFICATION"}%s\n\
\n\
{"#COLOUR_LGREEN"}Если вы не согласны с решением администратора - оставьте жалобу на форуме."
// --------------------------------------------------- ДИАЛОГ РЕГИСТРАЦИИ --------------------------------------------------- //
#define DLG_REG_PASSWORD_HEADER "{"#COLOUR_NOTIFICATION"}[1/4] Пароль"
#define DLG_REG_PASSWORD_STR "\n\
{FFFFFF}Добро пожаловать, {"#COLOUR_NOTIFICATION"}%s{FFFFFF}!\n\
Данный аккаунт {"#COLOUR_LGREEN"}не зарегистрирован{FFFFFF} на нашем сервере.\n\
Для начала игры на нашем сервере вы должны пройти регистрацию.\n\n\
Придумайте надеждый пароль для вашего аккаунта и нажмите \"Далее\".\n\
\t{E32636}• Пароль должен иметь длину от 8 до 32 символов\n\
\t{E32636}• Пароль должен состоять только из букв и цифр\n\
\t{E32636}• Пароль чувствителен к регистру"
#define DLG_REG_SEX_HEADER "{"#COLOUR_NOTIFICATION"}[2/4] Пол"
#define DLG_REG_SEX_LIST "Мужской\nЖенский"
#define DLG_REG_RACE_HEADER "{"#COLOUR_NOTIFICATION"}[3/4] Раса"
#define DLG_REG_RACE_LIST "Европеец\nАфроамериканец\nАзиат"
#define DLG_REG_REFERAL_HEADER "{"#COLOUR_NOTIFICATION"}[4/4] Реферал"
#define DLG_REG_REFERAL_STR "\n{FFFFFF}Ник игрока, пригласившего вас на сервер\nПример: {"#COLOUR_NOTIFICATION"}Olaf_Tormund"
#define DLG_REG_SUCCESS_MSG "[Уведомление] {FFFFFF}Регистрация почти завершена! Осталось выбрать одежду."
#define DLG_REG_EMPTY_MSG "[Ошибка] {FFFFFF}Вы ничего не ввели!"
#define DLG_REG_NOT_ALLOWED_PASS01_MSG "[Ошибка] {FFFFFF}Пароль должен иметь длину от 8 до 32 символов!"
#define DLG_REG_NOT_ALLOWED_PASS02_MSG "[Ошибка] {FFFFFF}Пароль должен состоять из букв и цифр!"
#define DLG_REG_REFERAL_NOT_FOUND01_MSG "[Ошибка]{FFFFFF} Игрок с таким ником не найден! Осталось попыток: %i"
#define DLG_REG_REFERAL_NOT_FOUND02_MSG "[Подсказка] {FFFFFF}Если вас никто не приглашал, то оставьте поле пустым или нажмите \"Пропуск\"."
#define DLG_REG_REFERAL_KICK_MSG "[Уведомление]{FFFFFF} Вы были кикнуты т.к. 3 раза ввели неверный ник. Перезайдите."
// --------------------------------------------------- ДИАЛОГ АВТОРИЗАЦИИ --------------------------------------------------- //
#define DLG_LOGIN_PASSWORD_HEADER "{"#COLOUR_NOTIFICATION"}Авторизация"
#define DLG_LOGIN_PASSWORD_STR "\n\
{FFFFFF}Добро пожаловать, {"#COLOUR_NOTIFICATION"}%s{FFFFFF}!\n\
Введите ваш пароль.\n\
\n\
Попыток для ввода пароля: {"#COLOUR_LGREEN"}%d{FFFFFF}"
#define DLG_LOGIN_SUCCESS_MSG "[Уведомление] {FFFFFF}Вы успешно вошли!"
#define DLG_LOGIN_PASSWORD_WRONG_STR "\n\
{FFFFFF}Добро пожаловать, {E88813}%s{FFFFFF}!\n\
\n\
{"#COLOUR_ERROR"}Неверный пароль!{FFFFFF}\n\
Попыток для ввода пароля: {"#COLOUR_ERROR"}%d{FFFFFF}"
#define DLG_LOGIN_PASSWORD_WRONG_MSG "[Уведомление]{FFFFFF} Вы были кикнуты т.к. 3 раза ввели неверный пароль!"
// --------------------------------------------------- ДИАЛОГ МЕНЮ --------------------------------------------------- //
#define DLG_MENU01_HEADER "{"#COLOUR_NOTIFICATION"}Меню игрока"
#define DLG_MENU01_LIST "\n\
{"#COLOUR_SRED"}[1] {FFFFFF}Параметры персонажа\n\
{"#COLOUR_SRED"}[2] {FFFFFF}Навыки персонажа\n\
{"#COLOUR_SRED"}[3] {FFFFFF}Связаться с администрацией\n\
{"#COLOUR_SRED"}[4] {FFFFFF}Настройки аккаунта\n\
{"#COLOUR_SRED"}[5] {FFFFFF}Помощь/список команд\n\
{"#COLOUR_SRED"}[6] {FFFFFF}Донат\n"

#define DLG_MENU02_HEADER "{"#COLOUR_NOTIFICATION"}Параметры персонажа"
#define DLG_MENU02_LIST "\n\
{"#COLOUR_SRED"}[1] {FFFFFF}Моя статистика\n\
{"#COLOUR_SRED"}[2] {FFFFFF}Меню автомобиля\n\
{"#COLOUR_SRED"}[3] {FFFFFF}Меню дома\n\
{"#COLOUR_SRED"}[4] {FFFFFF}Меню лидера\n\
{"#COLOUR_SRED"}[5] {FFFFFF}Меню семьи\n\
{"#COLOUR_SRED"}[6] {FFFFFF}Мои лицензии\n\
{"#COLOUR_SRED"}[7] {FFFFFF}Мой паспорт\n\
{"#COLOUR_SRED"}[8] {FFFFFF}Прогресс квестов\n\
{"#COLOUR_SRED"}[9] {FFFFFF}Сменить Non-RP ник"

#define DLG_MENU03_HEADER "{"#COLOUR_NOTIFICATION"}Навыки персонажа"
#define DLG_MENU03_LIST "\n\
{"#COLOUR_SRED"}[1] {FFFFFF}Навык стрельбы\n\
{"#COLOUR_SRED"}[2] {FFFFFF}Навык рукопашного боя\n\
{"#COLOUR_SRED"}[3] {FFFFFF}Навык вождения\n\
{"#COLOUR_SRED"}[4] {FFFFFF}Навык пилотирования\n\
{"#COLOUR_SRED"}[5] {FFFFFF}Навык фермера\n\
{"#COLOUR_SRED"}[6] {FFFFFF}Навык таксиста\n\
{"#COLOUR_SRED"}[7] {FFFFFF}Навык развозчика материалов\n\
{"#COLOUR_SRED"}[8] {FFFFFF}Навык дальнобойщика"

#define DLG_NONRP_NAME_HEADER "{"#COLOUR_NOTIFICATION"}Смена Non-RP ника"
#define DLG_NONRP_NAME_STR "Введите свой новый RP ник:\nПример: {"#COLOUR_NOTIFICATION"}Paul_McCartney"
#define DLG_NONRP_NAME_SUCCESS01_MSG "[Уведомление] Заявка на смену ника отправлена. Ожидайте подтверждения администрации."

#define DLG_STATS01_HEADER "{"#COLOUR_NOTIFICATION"}Статистика персонажа"
#define DLG_STATS01_STR "\n\
{FFFFFF}Имя: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Пол: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Раса: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Уровень: {"#COLOUR_NOTIFICATION"}%d\n\
{FFFFFF}Репутация: {"#COLOUR_NOTIFICATION"}[%d/%d]\n\
\n\
{FFFFFF}Наличные деньги: {"#COLOUR_NOTIFICATION"}$%d\n\
{FFFFFF}Деньги в банке: {"#COLOUR_NOTIFICATION"}$%d\n\
{FFFFFF}Деньги на депозите: {"#COLOUR_NOTIFICATION"}$%d\n\
\n\
{FFFFFF}Работа: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Организация: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Законопослушность: {"#COLOUR_NOTIFICATION"}[%d/100]\n\
{FFFFFF}Уровень розыска: {"#COLOUR_NOTIFICATION"}%d\n\
\n\
{FFFFFF}Номер телефона: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Номер банковского счета: {"#COLOUR_NOTIFICATION"}%s\n\
\n\
{FFFFFF}Игровой статус: {"#COLOUR_NOTIFICATION"}%s\n\
{FFFFFF}Рублей на счету: {"#COLOUR_NOTIFICATION"}%d руб.\n\
{FFFFFF}Предупреждения: {"#COLOUR_NOTIFICATION"}[%d/3]"
// --------------------------------------------------- АНТИЧИТЫ --------------------------------------------------- //
#define AC_AIRBREAK_VEHICLE_MSG "[AntiCheat]{FFFFFF} %s[%d] был кикнут за AirBreak [ByVehicle] [Ping:%d]"
#define AC_AIRBREAK_FOOT_MSG "[AntiCheat]{FFFFFF} %s[%d] был кикнут за AirBreak [ByFoot] [Ping:%d]"

#define AC_KICK_MSG "Вы были кикнуты по подозрению в читерстве!"
