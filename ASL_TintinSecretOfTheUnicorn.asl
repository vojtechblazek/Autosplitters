//The Adventures of Tintin: The Secret of the Unicorn Autosplitter by blazie
//version 1.4.1 for both game versions  date 20. 11. 2024    Changes: Fixed some splitting issues

state("TINTIN"){
    bool cutscene: "binkw32.dll", 0x2A91C; // direct, true if the game is playing a video cutscene (bink)
    bool loadRemove: "TINTIN.exe", 0x000223DC, 0x7D4; // pointer
    float posX: "TINTIN.exe", 0x5EE5F8; // direct
    float posY: "TINTIN.exe", 0x005FEBAC, 0x1CC, 0xEDC; // pointer
    float posZ: "TINTIN.exe", 0x5EE660; // direct
}

startup{   
    settings.Add("S", true, "Batch Split (split after exiting the book screen)");
        settings.Add("BOOK1", true, "After 1st Batch of chapters (Flea Market)", "S");
        settings.Add("BOOK2", true, "After 2nd Batch of chapters (Moulinsart)", "S");
        settings.Add("BOOK3", true, "After 3rd Batch of chapters (Karaboudjan)", "S");
        settings.Add("BOOK4", true, "After 4th Batch of chapters (Bagghar)", "S");
        settings.Add("BOOK5", true, "After 5th Batch of chapters (Brittany)", "S");
    
    settings.Add("ES", false, "In-Chapter Splits");
        settings.Add("MS1", true, "Moulinsart: The Salons", "ES");   
        settings.Add("KB1", true, "Karaboudjan: Up to the Wheelhouse (after cutscene)", "ES");
        settings.Add("KB2", true, "Karaboudjan: The Shipwreck (after cutscene)", "ES");
        settings.Add("BH1", true, "Bagghar: Find an Entrance to the Palace", "ES");
        settings.Add("BH2", true, "Bagghar: Omar Ben Salaad's Palace (underground)", "ES");
        settings.Add("BH3", true, "Bagghar: Palace Roofs", "ES");
        settings.Add("BH4", true, "Bagghar: After opening the Unicorn", "ES");
        settings.Add("BH5", true, "Bagghar: Escape from the Palace", "ES");
        settings.Add("BT1", true, "Brittany: After reuniting with Haddock", "ES");
        settings.Add("BT2", true, "Brittany: Climbing the tower (after cutscene)", "ES");
        settings.Add("BT3", true, "Brittany: Looking for Haddock (after parrot sequence)", "ES");
        settings.Add("BT4", true, "Brittany: After Allan bossfight", "ES");
        settings.Add("BT5", true, "Brittany: Cutscene after discovering the coordinates", "ES");
    
    settings.Add("FINS", false, "Individual chapter final splits (split when reaching the book screen)");
        settings.Add("FMFin", true, "Flea Market", "FINS");
        settings.Add("MSFin", true, "Moulinsart", "FINS");
        settings.Add("KBFin", true, "Karaboudjan", "FINS");
        settings.Add("BHFin", true, "Bagghar", "FINS");
        settings.Add("BTFin", true, "Brittany", "FINS");
}

init{
    vars.splitTriggered = false; // if this is set true, all flags reset and it sets itself to false again
    
    vars.bookFleaMarket = false;
    vars.bookMoulinsart = false;
    vars.bookKaraboudjan = false;
    vars.bookBagghar = false;
    vars.bookBrittany = false;
    vars.finalSplit = false;
    vars.gameFinished = false;
    vars.splitMS1 = false;
    vars.splitKB1 = false;
    vars.splitKB2 = false;
    vars.splitBH1 = false;
    vars.splitBH2 = false;
    vars.splitBH3 = false;
    vars.splitBH4 = false;
    vars.splitBH5 = false;
    vars.splitBT1 = false;
    vars.splitBT2 = false;
    vars.splitBT3 = false;
    vars.splitBT4 = false;
    vars.splitBT5 = false;

    vars.E1splitted = false; // these just check for logic conflicts with two book splits
    vars.E2splitted = false;
    vars.E3splitted = false;
    vars.E4splitted = false;
    vars.E5splitted = false;
}

update{
    if (vars.splitTriggered == true)
    {
        vars.splitTriggered = false;
        
        vars.bookFleaMarket = false;
        vars.bookMoulinsart = false;
        vars.bookKaraboudjan = false;
        vars.bookBagghar = false;
        vars.bookBrittany = false;
        vars.finalSplit = false;
        vars.gameFinished = false;
        vars.splitMS1 = false;
        vars.splitKB1 = false;
        vars.splitKB2 = false;
        vars.splitBH1 = false;
        vars.splitBH2 = false;
        vars.splitBH3 = false;
        vars.splitBH4 = false;
        vars.splitBH5 = false;
        vars.splitBT1 = false;
        vars.splitBT2 = false;
        vars.splitBT3 = false;
        vars.splitBT4 = false;
        vars.splitBT5 = false;
        
        vars.E1splitted = false; 
        vars.E2splitted = false;
        vars.E3splitted = false;
        vars.E4splitted = false;
        vars.E5splitted = false;
    }
    
    //BOOK SPLITS
    //Flea Market
    if (current.posX > 7 && current.posX < 7.4 &&   
        current.posY > 5.9 && current.posY < 6.1 &&
        current.posZ > 8 && current.posZ < 8.2 &&   
        vars.bookFleaMarket == false)
    {
        vars.bookFleaMarket = true;
    }
    //Moulinsart
    if (current.posX > -25 && current.posX < -21 &&   
        current.posY > -8 && current.posY < -7 &&
        current.posZ > -110 && current.posZ < -100 &&  
        vars.bookMoulinsart == false)
    {
        vars.bookMoulinsart = true;
    }
    //Karaboudjan
    if (current.posX > -250 && current.posX < -50 &&   
        current.posY > 625 && current.posY < 825 &&
        current.posZ > -1600 && current.posZ < -1400 && 
        vars.bookKaraboudjan == false)
    {
        vars.bookKaraboudjan = true;
    }
    //Bagghar
    if (current.posX > 3300 && current.posX < 3500 &&   
        current.posY > 300 && current.posY < 500 &&
        current.posZ > -300 && current.posZ < -100 &&   
        vars.bookBagghar == false)
    {
        vars.bookBagghar = true;
    }
    //Brittany
    if (current.posX > 100 && current.posX < 200 &&  
        current.posY > 160 && current.posY < 220 &&
        current.posZ > -270 && current.posZ < -210 &&  
        vars.bookBrittany == false)
    {
        vars.bookBrittany = true;
    }
    //Final Split
    if (current.posX > 308 && current.posX < 312 &&
        current.posY > -16 && current.posY < -14 &&
        current.posZ > -11 && current.posZ < -7 &&
        vars.finalSplit == false &&
        vars.gameFinished == false)
    { 
        vars.finalSplit = true;
    }

    //ADDITIONAL SPLITS
    if ((current.posX > 233 && current.posX < 243 && // MS1
        current.posY > 32 && current.posY < 35 &&
        current.posZ > 1.8 && current.posZ < 2.2) &&
        vars.splitMS1 == false)
    {
        vars.splitMS1 = true;
    }

    if ((current.posX > 31 && current.posX < 34 && // KB1
        current.posY > -7 && current.posY < -4 &&
        current.posZ > -38 && current.posZ < -33) &&
        vars.splitKB1 == false)
    {
        vars.splitKB1 = true;
    }

    if ((current.posX > -6 && current.posX < 10 && // KB2
        current.posY > 0 && current.posY < 10 &&
        current.posZ > 85 && current.posZ < 95) &&
        vars.splitKB2 == false)
    {
        vars.splitKB2 = true;
    }

    if ((current.posX > 50 && current.posX < 85 && // BH1
        current.posY > 15 && current.posY < 25 &&
        current.posZ > -410 && current.posZ < -370) &&
        vars.splitBH1 == false)
    {
        vars.splitBH1 = true;
    }

    if ((current.posX > 100 && current.posX < 105 && // BH2
        current.posY > -65 && current.posY < -50 &&
        current.posZ > 6 && current.posZ < 8) &&
        vars.splitBH2 == false)
    {
        vars.splitBH2 = true;
    }

    if ((current.posX > 125 && current.posX < 135 && // BH3
        current.posY > 75 && current.posY < 85 &&
        current.posZ > 5 && current.posZ < 7) &&
        vars.splitBH3 == false)
    {
        vars.splitBH3 = true;
    }

    if ((current.posX > 275 && current.posX < 285 && // BH4 (primes all the way back at the start of the Allan bossfight, since the unicorn coords were very common)
        current.posY > -35 && current.posY < -25 &&
        current.posZ > 0 && current.posZ < 3) &&
        vars.splitBH4 == false)
    {
        vars.splitBH4 = true;
    }

    if ((current.posX > -40 && current.posX < -30 && // BH5
        current.posY > -1 && current.posY < 1 &&
        current.posZ > 155 && current.posZ < 170) &&
        vars.splitBH5 == false)
    {
        vars.splitBH5 = true;
    }

    if ((current.posX > 360 && current.posX < 370 && // BT1
        current.posY > 34 && current.posY < 38 &&
        current.posZ > 9 && current.posZ < 13) &&
        vars.splitBT1 == false)
    {
        vars.splitBT1 = true;
    }

    if ((current.posX > 278 && current.posX < 288 && // BT2
        current.posY > -50 && current.posY < -39 &&
        current.posZ > 17 && current.posZ < 23) &&
        vars.splitBT2 == false && current.cutscene == false)
    {
        vars.splitBT2 = true;
    }

    if ((current.posX > 520 && current.posX < 530 && // BT3
        current.posY > 55 && current.posY < 65 &&
        current.posZ > 8 && current.posZ < 10) &&
        vars.splitBT3 == false)
    {
        vars.splitBT3 = true;
    }

    if ((current.posX > 279 && current.posX < 283 && // BT4
        current.posY > -43 && current.posY < -39 &&
        current.posZ > 11 && current.posZ < 14) &&
        vars.splitBT4 == false)
    {
        vars.splitBT4 = true;
    }

    if ((current.posX > 0 && current.posX < 3 && // BT5
        current.posY > 2 && current.posY < 4 &&
        current.posZ > 50 && current.posZ < 54) &&
        vars.splitBT5 == false)
    {
        vars.splitBT5 = true;
    }
}

start{
    return current.cutscene && !old.cutscene;
}

split{
    // Ending split
    if (vars.finalSplit == true && current.cutscene == true)
    {
        vars.finalSplit = false;
        vars.gameFinished = true;
        vars.splitTriggered = true;
        return true;
    }
    
    //BOOK SPLITS
    if (
    (old.posX > 22 && old.posX < 22.5 && // Checks for book coordinates
     old.posY > 13 && old.posY < 13.1 &&
     old.posZ > 14.8 && old.posZ < 15) &&
    (current.posX < 22 || current.posX > 22.5 ||
     current.posY < 13 || current.posY > 13.1 ||
     current.posZ < 14.8 || current.posZ > 15))
    {
        // Flea Market
        if (vars.bookFleaMarket == true && settings["BOOK1"])
        {
            vars.bookFleaMarket = false;
            vars.splitTriggered = true;
            return settings["BOOK1"];
        }
        // Moulinsart
        else if (vars.bookMoulinsart == true && settings["BOOK2"])
        {
            vars.bookMoulinsart = false;
            vars.splitTriggered = true;
            return settings["BOOK2"];
        }
        // Karaboudjan
        else if (vars.bookKaraboudjan == true && settings["BOOK3"])
        {
            vars.bookKaraboudjan = false;
            vars.splitTriggered = true;
            return settings["BOOK3"];
        }
        //Bagghar
        else if (vars.bookBagghar == true && settings["BOOK4"])
        {
            vars.bookBagghar = false;
            vars.splitTriggered = true;
            return settings["BOOK4"];
        }
        //Brittany
        else if (vars.bookBrittany == true && settings["BOOK5"])
        {
            vars.bookBrittany = false;
            vars.splitTriggered = true;
            return settings["BOOK5"];
        }
    }

    // INDIVIDUAL CHAPTERS FINAL SPLITS
    if(old.posX > 22 && old.posX < 22.5 && // Checks for book coordinates
      old.posY > 13 && old.posY < 13.1 &&
      old.posZ > 14.8 && old.posZ < 15 )
      {
        // Flea Market
        if (vars.bookFleaMarket == true && settings["FMFin"] && !vars.E1splitted)
        {
            if (!settings["BOOK1"]){
                vars.bookFleaMarket = false;
                vars.splitTriggered = true;}
            vars.E1splitted = true;
            return settings["FMFin"];
        }
        // Moulinsart
        else if (vars.bookMoulinsart == true && settings["MSFin"] && !vars.E2splitted)
        {
            if (!settings["BOOK2"]){
                vars.bookMoulinsart = false;
                vars.splitTriggered = true;}
            vars.E2splitted = true;
            return settings["MSFin"];
        }
        // Karaboudjan
        else if (vars.bookKaraboudjan == true && settings["KBFin"] && !vars.E3splitted)
        {
            if (!settings["BOOK3"]){
                vars.bookKaraboudjan = false;
                vars.splitTriggered = true;}
            vars.E3splitted = true;
            return settings["KBFin"];
        }
        //Bagghar
        else if (vars.bookBagghar == true && settings["BHFin"] && !vars.E4splitted)
        {
            if (!settings["BOOK4"]){
                vars.bookBagghar = false;
                vars.splitTriggered = true;}
            vars.E4splitted = true;
            return settings["BHFin"];
        }
        //Brittany
        else if (vars.bookBrittany == true && settings["BTFin"] && !vars.E5splitted)
        {
            if (!settings["BOOK5"]){
                vars.bookBrittany = false;
                vars.splitTriggered = true;}
            vars.E5splitted = true;
            return settings["BTFin"];
        }
      }

    //  IN-CHAPTER SPLITS
    if (
    (current.posX > 10 && current.posX < 12 && // MS1
     current.posY > -1 && current.posY < 1 &&
     current.posZ > 5 && current.posZ < 7) &&
     vars.splitMS1 == true)
    {
        vars.splitMS1 = false;
        vars.splitTriggered = true;
        return settings["MS1"];
    }

    if (
    (current.posX > 2 && current.posX < 3 && // KB1
     current.posY > 0 && current.posY < 1 &&
     current.posZ > 3 && current.posZ < 5) &&
     vars.splitKB1 == true)
    {
        vars.splitKB1 = false;
        vars.splitTriggered = true;
        return settings["KB1"];
    }

    if (
    (current.posX > -59 && current.posX < -55 && // KB2
     current.posY > -1 && current.posY < 1 &&
     current.posZ > 7 && current.posZ < 8) &&
     vars.splitKB2 == true)
    {
        vars.splitKB2 = false;
        vars.splitTriggered = true;
        return settings["KB2"];
    }

    if (
    (current.posX > -755 && current.posX < -735 && // BH1
     current.posY > -10 && current.posY < -7 &&
     current.posZ > 945 && current.posZ < 965) &&
     vars.splitBH1 == true)
    {
        vars.splitBH1 = false;
        vars.splitTriggered = true;
        return settings["BH1"];
    }

    if (
    (current.posX > -195 && current.posX < -185 && // BH2
     current.posY > 35 && current.posY < 45 &&
     current.posZ > 9 && current.posZ < 11) &&
     vars.splitBH2 == true)
    {
        vars.splitBH2 = false;
        vars.splitTriggered = true;
        return settings["BH2"];
    }

    if (
    (current.posX > -70 && current.posX < -60 && // BH3
     current.posY > -4 && current.posY < 0 &&
     current.posZ > -1 && current.posZ < 1) &&
     vars.splitBH3 == true)
    {
        vars.splitBH3 = false;
        vars.splitTriggered = true;
        return settings["BH3"];
    }

    if (
    (current.posX > -135 && current.posX < -125 && // BH4 
     current.posY > 6 && current.posY < 8 &&
     current.posZ > 1 && current.posZ < 3) &&
     vars.splitBH4 == true)
    {
        vars.splitBH4 = false;
        vars.splitTriggered = true;
        return settings["BH4"];
    }

    if (
    (current.posX > -375 && current.posX < -365 && // BH5
     current.posY > -25 && current.posY < -15 &&
     current.posZ > -110 && current.posZ < -95) &&
     vars.splitBH5 == true)
    {
        vars.splitBH5 = false;
        vars.splitTriggered = true;
        return settings["BH5"];
    }

    if (
    (current.posX > 6 && current.posX < 8 && // BT1
     current.posY > 50 && current.posY < 56 &&
     current.posZ > 7 && current.posZ < 9) &&
     vars.splitBT1 == true)
    {
        vars.splitBT1 = false;
        vars.splitTriggered = true;
        return settings["BT1"];
    }

    if (
    (current.posX > 278 && current.posX < 288 && // BT2, works differently (starts at a cutscene)
     current.posY > -50 && current.posY < -39 &&
     current.posZ > 17 && current.posZ < 23) &&
     vars.splitBT2 == true && current.cutscene == true)
    {
        vars.splitBT2 = false;
        vars.splitTriggered = true;
        return settings["BT2"];
    }

    if (
    (current.posX > -4 && current.posX < 0 && // BT3
     current.posY > 1 && current.posY < 2 &&
     current.posZ > 21 && current.posZ < 25) &&
     vars.splitBT3 == true)
    {
        vars.splitBT3 = false;
        vars.splitTriggered = true;
        return settings["BT3"];
    }

    if (
    (current.posX > 71 && current.posX < 73 && // BT4
     current.posY > 7.5 && current.posY < 8.5 &&
     current.posZ > 9 && current.posZ < 11) &&
     vars.splitBT4 == true)
    {
        vars.splitBT4 = false;
        vars.splitTriggered = true;
        return settings["BT4"];
    }

    if (
    (current.posX > 1 && current.posX < 1.5 && // BT5
     current.posY > 0 && current.posY < 0.5 &&
     current.posZ > 0 && current.posZ < 1) &&
     vars.splitBT5 == true && current.cutscene == true)
    {
        vars.splitBT5 = false;
        vars.splitTriggered = true;
        return settings["BT5"];
    } 
}

isLoading{
    return current.loadRemove && !current.cutscene;
}

onReset{
    vars.splitTriggered = true;
    vars.gameFinished = false;
}

exit{
    vars.splitTriggered = true;
    vars.gameFinished = false;
}
