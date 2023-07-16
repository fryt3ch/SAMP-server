// Performed by frytech

stock date(unix = 0, gmt = 6, formatLine[] = "%02d.%02d.%d, %02d:%02d:%02d")
{
	new _ys = floatround(unix / (366*24*60*60), floatround_floor); // years since 1970 (Ex. 49)
	new _y = 1970 + _ys; // current year (Ex. 2019)

	new Boolean: isLeap = false; // Високосный год?
	if (((_y % 4 == 0) & (_y % 100 != 0)) || (_y % 400 == 0)) isLeap = true;

	new _tunix = unix; // temp
	new _i; // each year after 1970 until current year (1970, 1971, 1972 .. 2018) We don't need current year (2019)

	for (new i = 0; i < _ys; i++) // calculating amount of time passed current year (timestamp - seconds by 1970 till 2018)
	{
		_i = 1970 + i;
		if (((_i % 4 == 0) & (_i % 100 != 0)) || (_i % 400 == 0)) _tunix -= 366*24*60*60; else _tunix -= 365*24*60*60;
	}

	_tunix = _tunix + (gmt*60*60); // dependending on timezone (+6 GMT - Omsk, +3 - Moscow, 0 - UTC)

	new _dpty = _tunix/60/60/24; // amount of days passed this year (ex. 88 days)
	new _d = _dpty; _d++; // we add one extra day because the beginning of each month is 01 (Ex. 01.01.2019)
	new _m = 1; // the first month (Jan);
	new x = 31; // amount of days in Jan.

	for (_m; _m <= 12; _m++)
	{
		if (_d <= x) break; else
		{
			_d -= x;
			if (_m == 1) if (isLeap) x = 29; else x = 28;
			else if (_m == 3 || _m == 5 || _m == 8  || _m == 10) x = 30; else x = 31;
		}
	}

	_tunix = _tunix - (_dpty*24*60*60); // we calculate the total amount of seconds in current day

	new _h, _min, _s;
	_h = _tunix / 3600; // hours
	_min = (_tunix - _h * 3600) / 60; // minutes
	_s = _tunix - (_h * 3600) - (_min * 60); // seconds

	new output[32]; format(output, sizeof(output), formatLine, _d, _m, _y, _h, _min, _s); // formatg string by the pattern
	return output;
}
