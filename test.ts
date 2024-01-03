import { SyncedTime } from "./SyncedTime"


function onEvent() {
    SyncedTime.GetTime();
}

function start() {
    SyncedTime.AverageCheckRate = 10;
    
    // Start the module right away
    SyncedTime.Init();
}

start();

// ... run some event logic code

onEvent();