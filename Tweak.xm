@interface HKHeartRhythmAvailability
- (void)resetElectrocardiogramOnboarding;
+ (id)activePairedDevice;
+ (BOOL)isElectrocardiogramSupportedOnWatch:(id)watch;
+ (void)installElectrocardiogramAppOnActiveWatch:(id)watch;
- (void)setElectrocardiogramOnboardingCompleted;
- (void)setAllowInstallingElectrocardiogramWatchApp:(BOOL)arg;
@end

extern "C" int HKSynchronizeNanoPreferencesUserDefaults(NSString* key, NSSet* value);

BOOL alertShowed = NO;
#define dictPath @"/var/mobile/Library/Preferences/com.apple.private.health.heart-rhythm.plist"

%group NanoSettingsSync
%hook HKHeartRhythmAvailability
- (bool)isElectrocardiogramOnboardingCompleted {
    HKSynchronizeNanoPreferencesUserDefaults(@"com.apple.private.health.heart-rhythm", [NSSet setWithObject:@"HKElectrocardiogramOnboardingCompleted"]);
    
    if (alertShowed == NO) {
        id device = [%c(HKHeartRhythmAvailability) activePairedDevice];
        if (device) {
            BOOL support = [%c(HKHeartRhythmAvailability) isElectrocardiogramSupportedOnWatch:device];
            if (support == NO) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ECG Enabler Error" message:@"Your Apple Watch hardware region doesn't support ECG currently." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alertShowed = YES;
            }
            else {
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:dictPath];
                dict[@"ECGEnablerDone"] = @YES;
                [dict writeToFile:dictPath atomically:YES];

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ECG Enabler Success" message:@"Your Apple Watch ECG feature is enabled.\n\nIf it doesn't work, try to pair your Apple Watch again without restoring backup." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alertShowed = YES;
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ECG Enabler Error" message:@"Cannot find paired Apple Watch." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alertShowed = YES;
        }
    }
    return YES;
}

- (bool)isAtrialFibrillationDetectionOnboardingCompleted {
    HKSynchronizeNanoPreferencesUserDefaults(@"com.apple.private.health.heart-rhythm", [NSSet setWithObject:@"HKAtrialFibrillationDetectionOnboardingCompleted"]);
    return YES;
}
%end
%end

%group BypassMPN
%hook HKHeartRhythmAvailability
- (bool)isElectrocardiogramOnboardingCompleted {
    BOOL result = %orig;
    if (resetECG != YES && result != YES) {
        [self resetElectrocardiogramOnboarding];
        [self setElectrocardiogramOnboardingCompleted];
        [self setAllowInstallingElectrocardiogramWatchApp:YES];

        // id device = [%c(HKHeartRhythmAvailability) activePairedDevice];
        // if (device) {
        //     [%c(HKHeartRhythmAvailability) installElectrocardiogramAppOnActiveWatch:device];
        // }
        resetECG = YES;

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ECG Enabler Success" message:@"ECG feature is enabled, you can remove this tweak now.\nIf ECG app doesn't appear on your Apple Watch, try to search and download it in the AppStore of your watch." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

        NSString *path = @"/var/mobile/Library/Preferences/com.apple.private.health.heart-rhythm.plist";
        NSDictionary *dict = @{@"HKElectrocardiogramOnboardingCompleted" : @3, @"HKAtrialFibrillationDetectionOnboardingCompleted" : @1};
        [dict writeToFile:path atomically:YES];
    }
    return %orig;
}
%end

%hook NSUserDefaults
-(bool)hk_electrocardiogramWatchAppInstallHasBeenAllowed {
    return YES;
}
%end
%end

%ctor {
    %init;
}