#import <Foundation/Foundation.h>

int main(int argc, char **argv, char **envp) 
{
    NSString *path = @"/var/mobile/Library/Preferences/com.apple.private.health.heart-rhythm.plist";
    NSDictionary *dict = @{@"HKElectrocardiogramOnboardingCompleted" : @3, @"HKAtrialFibrillationDetectionOnboardingCompleted" : @1};
    [dict writeToFile:path atomically:YES];

    return 0;
}
