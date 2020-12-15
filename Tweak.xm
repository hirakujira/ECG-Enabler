#import <firmware.h>
#import <UIKit/UIKit.h>

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
BOOL resetECG = NO;

#define dictPath @"/var/mobile/Library/Preferences/com.apple.private.health.heart-rhythm.plist"
#define defaultsId @"com.apple.private.health.heart-rhythm"

%group NanoSettingsSync
%hook HKHeartRhythmAvailability
- (bool)isElectrocardiogramOnboardingCompleted {
    HKSynchronizeNanoPreferencesUserDefaults(defaultsId, [NSSet setWithObject:@"HKElectrocardiogramOnboardingCompleted"]);
    
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
    HKSynchronizeNanoPreferencesUserDefaults(defaultsId, [NSSet setWithObject:@"HKAtrialFibrillationDetectionOnboardingCompleted"]);
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

        resetECG = YES;

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ECG Enabler Success" message:@"ECG feature is enabled, you can remove this tweak now.\nIf ECG app doesn't appear on your Apple Watch, then you must re-pair your Apple Watch with restoring backup." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

        NSNumber *ecgVersion = @3;
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_14_3) {
            ecgVersion = @4;
        }

        NSDictionary *dict = @{@"HKElectrocardiogramOnboardingCompleted" : ecgVersion, @"HKAtrialFibrillationDetectionOnboardingCompleted" : @1};
        [dict writeToFile:dictPath atomically:YES];
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

    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_13_4) {
        %init(BypassMPN);
    }
    else if ([[NSFileManager defaultManager] fileExistsAtPath:dictPath]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:dictPath];
        if ([dict[@"ECGEnablerDone"] boolValue] != YES) {
            %init(NanoSettingsSync);
        }
    }
}