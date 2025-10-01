// Pilgrims Autosplitter by blazie
// Utilising ASL Help by Ero
// v1.0.2
// 1. 10. 2025

state("Pilgrims"){
	bool mouseInput: "UnityPlayer.dll", 0x00408C50, 0x0; // for starting the run
}

startup{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;

	vars.inGarden 	 = false; vars.inRiver 		 = false; vars.inForestCamp2 = false;
	vars.inOldOak 	 = false; vars.inBridge 	 = false; vars.inPub 		 = false;
	vars.inHut 		 = false; vars.inDwarf		 = false; vars.inPit 		 = false;
	vars.inChurch 	 = false; vars.inForestCamp1 = false; vars.inPond		 = false;
	vars.inBearCave	 = false; vars.inDrawBridge	 = false; vars.inCastle 	 = false;
	vars.inGorge	 = false; // sets every location as "not visited yet"

	settings.Add("Splits",     true, "Split at:");                            settings.SetToolTip("Splits", "Splitting happens ONLY the first time you enter the ticked location!");
	settings.Add("GARDEN",     true, "Potato garden",			"Splits");
	settings.Add("RIVER",      true, "River (ferrylady)",		"Splits");
	settings.Add("FCAMP2",     true, "Lower forest camp",		"Splits");
	settings.Add("OLDOAK",     true, "Old oak (bandit)",		"Splits");
	settings.Add("BRIDGE",     true, "Bridge with old lady",	"Splits");
	settings.Add("PUB",        true, "Pub",						"Splits");
	settings.Add("HUT",        true, "Witch hut",				"Splits");
	settings.Add("DWARF",      true, "Dwarf (water sprite)",	"Splits");
	settings.Add("PIT",        true, "Devils pit",				"Splits");
	settings.Add("CHURCH",     true, "Church",					"Splits");
	settings.Add("FCAMP1",     true, "Upper forest camp",		"Splits");
	settings.Add("POND",       true, "Fish pond",				"Splits");
	settings.Add("BEARCAVE",   true, "Bear cave",				"Splits");
	settings.Add("DRAWBRIDGE", true, "Drawbridge",				"Splits");
	settings.Add("CASTLE",     true, "Castle",					"Splits");
	settings.Add("GORGE",      true, "Gorge",					"Splits");
}

init{
    old.Scene = ""; current.Scene = "";
    old.SceneCount = ""; current.SceneCount = "";
	old.Level = "<default>"; current.Level = "<default>";

    vars.levelName = "";
	vars.isFirst = true;
}

update{
	current.Scene = vars.Helper.Scenes.Active.Name ?? old.Scene;
	
	foreach (var scene in vars.Helper.Scenes.Loaded) {
    try{
        if (scene != null && scene.IsValid){
            vars.levelName = scene.Name ?? "<null>";
        }	
		else{
            vars.levelName = "<invalid>";
        }
    }
	catch{vars.levelName = "<error>";}
    break;
	}

	// Filtering
	if (vars.levelName != "<error>" && vars.levelName != "" && vars.levelName != "<null>" && vars.levelName != "<invalid>"){
		current.Level = vars.levelName;
	}
	else{
		current.Level = old.Level; // this is redundant
	}
	// (When on the map, <error>, <null> or "" was thrown)
}

start{
	return current.Level == "HobosLair" && current.mouseInput == true;
}

split{
	if     (current.Level != old.Level){		
		if (current.Level == "Garden"      && vars.inGarden == false) 	   {vars.inGarden = true;      return settings["GARDEN"];}
		if (current.Level == "River"       && vars.inRiver == false)   	   {vars.inRiver = true;       return settings["RIVER"];}
		if (current.Level == "ForestCamp2" && vars.inForestCamp2 == false) {vars.inForestCamp2 = true; return settings["FCAMP2"];}
		if (current.Level == "OldOak"      && vars.inOldOak == false)      {vars.inOldOak = true;      return settings["OLDOAK"];}
		if (current.Level == "Bridge"      && vars.inBridge == false)      {vars.inBridge = true;      return settings["BRIDGE"];}
	    if (current.Level == "Pub"         && vars.inPub == false)         {vars.inPub = true;         return settings["PUB"];}
		if (current.Level == "Hut"         && vars.inHut == false)         {vars.inHut = true;         return settings["HUT"];}
		if (current.Level == "Dwarf"       && vars.inDwarf == false)       {vars.inDwarf = true;       return settings["DWARF"];}
		if (current.Level == "Pit"         && vars.inPit == false)         {vars.inPit = true;         return settings["PIT"];}
		if (current.Level == "Church"      && vars.inChurch == false)      {vars.inChurch = true;      return settings["CHURCH"];}
		if (current.Level == "ForestCamp1" && vars.inForestCamp1 == false) {vars.inForestCamp1 = true; return settings["FCAMP1"];}
		if (current.Level == "Pond"        && vars.inPond == false)        {vars.inPond = true;        return settings["POND"];}
		if (current.Level == "BearCave"    && vars.inBearCave == false)    {vars.inBearCave = true;    return settings["BEARCAVE"];}
		if (current.Level == "Drawbridge"  && vars.inDrawBridge == false)  {vars.inDrawBridge = true;  return settings["DRAWBRIDGE"];}
		if (current.Level == "Castle"      && vars.inCastle == false)      {vars.inCastle = true;      return settings["CASTLE"];}
		if (current.Level == "Gorge"       && vars.inGorge == false)       {vars.inGorge = true;       return settings["GORGE"];}
		if (current.Level == "Outro"       && old.Level == "River")        {return true;} // ending the run
	}
}

reset{
    if (current.Level == "Intro" && old.Level != "Intro")     {return true;}
	if (current.Level != "Outro" && old.Level == "Outro")     {return true;}
}

onReset{
	vars.inGarden 	 = false; vars.inRiver 		 = false; vars.inForestCamp2 = false;
	vars.inOldOak 	 = false; vars.inBridge 	 = false; vars.inPub 		 = false;
	vars.inHut 		 = false; vars.inDwarf		 = false; vars.inPit 		 = false;
	vars.inChurch 	 = false; vars.inForestCamp1 = false; vars.inPond		 = false;
	vars.inBearCave	 = false; vars.inDrawBridge	 = false; vars.inCastle 	 = false;
	vars.inGorge	 = false;
}

exit{
	vars.inGarden 	 = false; vars.inRiver 		 = false; vars.inForestCamp2 = false;
	vars.inOldOak 	 = false; vars.inBridge 	 = false; vars.inPub 		 = false;
	vars.inHut 		 = false; vars.inDwarf		 = false; vars.inPit 		 = false;
	vars.inChurch 	 = false; vars.inForestCamp1 = false; vars.inPond		 = false;
	vars.inBearCave	 = false; vars.inDrawBridge	 = false; vars.inCastle 	 = false;
	vars.inGorge	 = false;
}
