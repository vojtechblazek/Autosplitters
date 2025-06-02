// Version 2.0.0
// There was a technical update in March of 2025, which broke the previous splitter. This is a hotfix for the new version.
// Note that the previous splitter doesn't even work with the DirectX9 32bit Backwards Compatible version of the game, as it's not the same.
// For the old version, go to the steam console and download it with "download_depot 40700 40701 3658574386657440524"
//Changes: Version focused on debugging - outputting important data to winlog

state("Machinarium"){
    uint Level: "Machinarium.exe", 0x203A18; // Value for changing levels. Table with values at the end of script. Direct adress, no pointers found.
    bool LastAnimation: "Machinarium.exe", 0x2039EC; // Start + End Start: Goes from 1 to 0. End: Goes from 0 to 1. add 14.333 s to this, so it matches the run ending
}

startup{
    vars.splitTimeStopwatch = new Stopwatch(); // for ending split 
    vars.TimesInPrison = 0; // Count how many times the player has been in specific locations.
    vars.TimesInSewer = 0;
    vars.TimesInBand = 0;
    vars.TimesInSquare = 0;
    vars.TimesInPub = 0;
    vars.startDbg = 0;

    settings.Add("MAIN", true, "Settings");       
        settings.Add("SCREENSPLITS", true, "Splits Between Locations", "MAIN");
            settings.Add("PatrolStation", true, "Patrol Station", "SCREENSPLITS");
            settings.Add("Bottom", true, "The Bottom", "SCREENSPLITS");
            settings.Add("Furnace", true, "Furnace", "SCREENSPLITS");
            settings.Add("PrisonCutscene", true, "Cutscene before prison", "SCREENSPLITS");
            settings.Add("Prison", true, "Prison", "SCREENSPLITS");
            settings.Add("GuardRoom", true, "Guard Room (from below)", "SCREENSPLITS");
            settings.Add("PrisonPuzzle", true, "Prison Puzzle", "SCREENSPLITS");
            settings.Add("Sea", true, "The Sea (dog location)", "SCREENSPLITS");
            settings.Add("Band", true, "Robot Band Location", "SCREENSPLITS");
            settings.Add("AfterCheckers", true, "Robot Band Location (after Checkers)", "SCREENSPLITS");
            settings.Add("Square", true, "Square", "SCREENSPLITS");
            settings.Add("ArcadeBridge", true, "Arcade Bridge", "SCREENSPLITS");
            settings.Add("AfterArcade", true, "Square (after Arcade Bridge)", "SCREENSPLITS");
            settings.Add("AfterOil", true, "Robot Band Location (after oil collection)", "SCREENSPLITS");
            settings.Add("Sewer", true, "Sewer", "SCREENSPLITS");
            settings.Add("Wall", true, "By The Wall", "SCREENSPLITS");
            settings.Add("AngryFan", true, "Sleeping Fan", "SCREENSPLITS");
            settings.Add("Glasshouse", true, "Glasshouse", "SCREENSPLITS");
            settings.Add("Pipes", true, "Policeman on bridge", "SCREENSPLITS");
            settings.Add("ElevatorAfterPipes", true, "Elevator (from policeman)", "SCREENSPLITS");
            settings.Add("Hallway", true, "Hallway", "SCREENSPLITS");
            settings.Add("AfterDefuse", true, "Toilet (after defuse)", "SCREENSPLITS");
            settings.Add("Machinari", true, "Machinaris chamber", "SCREENSPLITS");
            settings.Add("AfterMachinari", true, "Basement trip", "SCREENSPLITS");
            settings.Add("Roof", true, "Roof", "SCREENSPLITS");
        
        settings.Add("EVENTSPLITS", true, "Event Splits", "MAIN");
            settings.Add("Dunno", true, "No event splits yet. Any ideas?", "EVENTSPLITS");
}

update{ // Keeping track of frequently visited locations
    if (current.Level == 600 && old.Level != 600){
        vars.TimesInPrison++;
    }
    if (current.Level == 1400 && old.Level != 1400){
        vars.TimesInSewer++;
    }
    if (current.Level == 1000 && old.Level != 1000){
        vars.TimesInBand++;
    }
    if (current.Level == 1100 && old.Level != 1100){
        vars.TimesInSquare++;
    }
    if (current.Level == 1500 && old.Level != 1500){
        vars.TimesInTimesInPub++;
    }
//Debugging section
    if (current.Level == 100 && !current.LastAnimation && old.LastAnimation){
        vars.startDbg += 1;
    }
    
    if (current.Level != old.Level){
        print("DEBUG: LEVEL VALUE CHANGED FROM " + old.Level + " TO " + current.Level);
    }
    if (current.LastAnimation != old.LastAnimation){
        print("DEBUG: LastAnimation VALUE CHANGED FROM " + old.LastAnimation + " TO " + current.LastAnimation);
    }
}

start{
    if (current.Level == 100 && !current.LastAnimation && old.LastAnimation && vars.startDbg == 2){
        print("DEBUG: START ACTIVATED");
        return true;
    }
}

split{
    if (current.Level == 200 && old.Level == 6){ // Entering patrol station
        return settings["PatrolStation"];
    }
    if (current.Level == 300 && old.Level != 300){ // Entering the bottom
        return settings["Bottom"];
    }
    if (current.Level == 400 && old.Level != 400){ // Entering the furnace
        return settings["Furnace"];
    }
    if (current.Level == 500 && old.Level == 400){ // As the prison cutscene starts to play
        return settings["PrisonCutscene"];
    }
    if (current.Level == 600 && old.Level == 500){ // As you get to prison 
        return settings["Prison"];
    }
    if (current.Level == 700 && old.Level == 600 && vars.TimesInPrison == 1){ // Entering the guard room from below
        return settings["GuardRoom"];
    }
    if (current.Level == 600 && old.Level == 700){ // Entering the prison from the guard room
        return settings["PrisonPuzzle"];
    }
    if (current.Level == 800 && old.Level == 500){ // Entering the Sea from the telescope room (location with boxes and a dog)
        return settings["Sea"];
    }
    if (current.Level == 1000 && old.Level == 800){ // Entering the place with the robot band from the Sea location
        return settings["Band"];
    }
    if (current.Level == 1000 && old.Level == 1500 && vars.TimesInBand == 2){ // Entering the place with the robot band after winning in checkers
        return settings["AfterCheckers"];
    }
    if (current.Level == 1100 && old.Level == 2100 && vars.TimesInSquare == 1){ // Entering the Square for the first time
        return settings["Square"];
    }
    if (current.Level == 1200 && old.Level == 1100){ // Entering the Arcade bridge location
        return settings["ArcadeBridge"];
    }
    if (current.Level == 1100 && old.Level == 1200 && vars.TimesInSquare == 2){ // Entering the Square after the Arcade Bridge
        return settings["AfterArcade"];
    }
    if (current.Level == 1000 && old.Level == 200){ // Entering the band place after collecting oil
        return settings["AfterOil"];
    }
    if (current.Level == 1400 && old.Level == 1100 && vars.TimesInSewer == 1){ // Entering the Sewer under the fountain. The location is entered 2 times, but we want to split only the first time.
        return settings["Sewer"];
    }
    if (current.Level == 1600 && old.Level == 1400){ // Entering the elevator wall.
        return settings["Wall"];
    }
    if (current.Level == 1800 && old.Level == 1600){ // Entering the upper wall (with the fan asking you riddles)
        return settings["AngryFan"];
    }
    if (current.Level == 1900 && old.Level == 1800){ // Falling down to the glasshouse
        return settings["Glasshouse"];
    }
    if (current.Level == 2000 && old.Level == 1900){ // Entering the bridge with the policeman.
        return settings["Pipes"];
    }
    if (current.Level == 2200 && old.Level == 2000){ // Entering the Elevator.
        return settings["ElevatorAfterPipes"];
    }
    if (current.Level == 2300 && old.Level == 2200){ // Entering the great hallway; Both sides count with the value 2300, 2200 is reserved for the elevator.
        return settings["Hallway"];
    }
    if (current.Level == 2300 && old.Level == 2400){ // Climbing to the toilet after defusing the bomb.
        return settings["AfterDefuse"];
    }
    if (current.Level == 2500 && old.Level == 2300){ // Entering the Machinaris room. Only once in the speedrun is it entered from the hallway. The second time it's connected right from the basement by a cutscene.
        return settings["Machinari"];
    }
    if (current.Level == 2300 && old.Level == 2500){ // When first coming down from Machinari to the basement.
        return settings["AfterMachinari"];
    }
    if (current.Level == 2600 && old.Level == 2500){ // Entering the rooftop at the end of the game
        return settings["Roof"];
    }
    if (current.Level == 2600 && current.LastAnimation == 1 && old.LastAnimation == 0){// When the last animation starts, this sets up a clock measuring 14.333 seconds.
        vars.splitTimeOffset = 14.333f;
        vars.splitTimeStopwatch.Restart();
    }    
    if(vars.splitTimeStopwatch.IsRunning && vars.splitTimeStopwatch.Elapsed.TotalSeconds >= vars.splitTimeOffset){ // When the clock reaches 14.333 secs (or more), the clock reset and a split is performed.
        vars.splitTimeStopwatch.Reset();
        return true;
    }
}

reset{
    if (current.Level == 6 && old.Level != 100 && old.Level != 6)
    {
        print("DEBUG: RESET");
        return true;
    }
}

onReset{
    vars.TimesInPrison = 0;
    vars.TimesInSewer = 0;
    vars.TimesInBand = 0;
    vars.TimesInSquare = 0;
    vars.TimesInPub = 0;
    vars.startDbg = 0;
}
exit{
    vars.TimesInPrison = 0;
    vars.TimesInSewer = 0;
    vars.TimesInBand = 0;
    vars.TimesInSquare = 0;
    vars.TimesInPub = 0;
    vars.startDbg = 0;
}
