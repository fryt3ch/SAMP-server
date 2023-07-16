#pragma library fry_textdraws

new Text: TD_REG_SKIN_BOX, TD_REG_SKIN_LEFT, TD_REG_SKIN_RIGHT, TD_REG_SKIN_SELECT;

stock InitializeTextDraws()
{
	TD_REG_SKIN_BOX = TextDrawCreate(250.0000, 300.0000, "Box"); // пусто
	TextDrawLetterSize(TD_REG_SKIN_BOX, 0.0000, 7.0000);
	TextDrawTextSize(TD_REG_SKIN_BOX, 394.6665, 0.0000);
	TextDrawAlignment(TD_REG_SKIN_BOX, 1);
	TextDrawColor(TD_REG_SKIN_BOX, -1);
	TextDrawUseBox(TD_REG_SKIN_BOX, 1);
	TextDrawBoxColor(TD_REG_SKIN_BOX, 255);
	TextDrawBackgroundColor(TD_REG_SKIN_BOX, 255);
	TextDrawFont(TD_REG_SKIN_BOX, 1);
	TextDrawSetProportional(TD_REG_SKIN_BOX, 1);
	TextDrawSetShadow(TD_REG_SKIN_BOX, 0);

	TD_REG_SKIN_SELECT = TextDrawCreate(300.0000, 322.0000, "SELECT"); // пусто
	TextDrawLetterSize(TD_REG_SKIN_SELECT, 0.4199, 2.0999);
	TextDrawTextSize(TD_REG_SKIN_SELECT, 350.0000, 20);
	TextDrawAlignment(TD_REG_SKIN_SELECT, 1);
	TextDrawColor(TD_REG_SKIN_SELECT, -1);
	TextDrawBackgroundColor(TD_REG_SKIN_SELECT, 255);
	TextDrawFont(TD_REG_SKIN_SELECT, 1);
	TextDrawSetProportional(TD_REG_SKIN_SELECT, 1);
	TextDrawSetShadow(TD_REG_SKIN_SELECT, 0);
	TextDrawSetSelectable(TD_REG_SKIN_SELECT, true);

	TD_REG_SKIN_RIGHT = TextDrawCreate(365.0000, 320.0000, ">>"); // пусто
	TextDrawLetterSize(TD_REG_SKIN_RIGHT, 0.5000, 2.5000);
	TextDrawTextSize(TD_REG_SKIN_RIGHT, 390, 20);
	TextDrawAlignment(TD_REG_SKIN_RIGHT, 1);
	TextDrawColor(TD_REG_SKIN_RIGHT, -1);
	TextDrawBackgroundColor(TD_REG_SKIN_RIGHT, 255);
	TextDrawFont(TD_REG_SKIN_RIGHT, 1);
	TextDrawSetProportional(TD_REG_SKIN_RIGHT, 1);
	TextDrawSetShadow(TD_REG_SKIN_RIGHT, 0);
	TextDrawSetSelectable(TD_REG_SKIN_RIGHT, true);

	TD_REG_SKIN_LEFT = TextDrawCreate(260.0000, 320.0000, "<<"); // пусто
	TextDrawLetterSize(TD_REG_SKIN_LEFT, 0.5000, 2.5000);
	TextDrawTextSize(TD_REG_SKIN_LEFT, 285.0000, 20);
	TextDrawAlignment(TD_REG_SKIN_LEFT, 1);
	TextDrawColor(TD_REG_SKIN_LEFT, -1);
	TextDrawBackgroundColor(TD_REG_SKIN_LEFT, 255);
	TextDrawFont(TD_REG_SKIN_LEFT, 1);
	TextDrawSetProportional(TD_REG_SKIN_LEFT, 1);
	TextDrawSetShadow(TD_REG_SKIN_LEFT, 0);
	TextDrawSetSelectable(TD_REG_SKIN_LEFT, true);
}

stock DestroyTextDraws()
{
	TextDrawDestroy(TD_REG_SKIN_BOX);
	TextDrawDestroy(TD_REG_SKIN_LEFT);
	TextDrawDestroy(TD_REG_SKIN_RIGHT);
	TextDrawDestroy(TD_REG_SKIN_SELECT);
}
