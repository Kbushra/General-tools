if global.save.killCount[global.save.area] <= 0 { play_bgm(sndNobody); }
if global.debugMute { busBGM.gain = 0; busSFX.gain = 0; }
	else if busBGM.gain == 0 && busSFX == 0 { busBGM.gain = 1; busSFX.gain = 1; }