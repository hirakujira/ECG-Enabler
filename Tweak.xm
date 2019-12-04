extern "C" int HKSynchronizeNanoPreferencesUserDefaults(NSString* key, NSSet* value);

%hook HKHeartRhythmAvailability
- (bool)isElectrocardiogramOnboardingCompleted {
    HKSynchronizeNanoPreferencesUserDefaults(@"com.apple.private.health.heart-rhythm", [NSSet setWithObject:@"HKElectrocardiogramOnboardingCompleted"]);
    return YES;
}

- (bool)isAtrialFibrillationDetectionOnboardingCompleted {
    HKSynchronizeNanoPreferencesUserDefaults(@"com.apple.private.health.heart-rhythm", [NSSet setWithObject:@"HKAtrialFibrillationDetectionOnboardingCompleted"]);
    return YES;
}
%end

%ctor {
    %init;
}