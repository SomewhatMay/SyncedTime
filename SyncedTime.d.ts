interface SyncedTime {
    AverageCheckRate: number;
    
    Init(useLocalAverage?: number, localCheckRate?: number, resetGlobalAverage?: number): void;
    
    GetTime(): number;
}

export declare const SyncedTime: SyncedTime;