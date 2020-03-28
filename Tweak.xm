@interface HKHeartRhythmAvailability
- (void)resetElectrocardiogramOnboarding;
+ (id)activePairedDevice;
+ (BOOL)isElectrocardiogramSupportedOnWatch:(id)watch;
@end

extern "C" int HKSynchronizeNanoPreferencesUserDefaults(NSString* key, NSSet* value);

BOOL alertShowed = NO;
#define dictPath @"/var/mobile/Library/Preferences/com.apple.private.health.heart-rhythm.plist"

%ctor {
    %init;
}