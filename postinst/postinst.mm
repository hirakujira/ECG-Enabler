#import <Foundation/Foundation.h>
#import <spawn.h>

static void easy_spawn(const char* args[]) {
    pid_t pid;
    int status;
    posix_spawn(&pid, args[0], NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
}

int main(int argc, char **argv, char **envp) 
{
    NSString *path = @"/var/mobile/Library/Preferences/com.apple.private.health.heart-rhythm.plist";
    NSDictionary *dict = @{@"HKElectrocardiogramOnboardingCompleted" : @3, @"HKAtrialFibrillationDetectionOnboardingCompleted" : @1};
    [dict writeToFile:path atomically:YES];

    easy_spawn((const char *[]){"/bin/chown", "mobile:mobile", "/var/mobile/Library/Preferences/com.apple.private.health.heart-rhythm.plist", NULL});
    easy_spawn((const char *[]){"/bin/chmod", "644", "/var/mobile/Library/Preferences/com.apple.private.health.heart-rhythm.plist", NULL});

    return 0;
}
