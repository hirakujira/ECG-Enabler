# ECG Enabler

## Features

Enable ECG function anywhere with Apple Watch S4+ which is bought from ECG-enabled region.

From iOS 12.2 and newer iOS versions, you must connect your iPhone to a cellular network in ECG enabled countries / regions to enable ECG feature of the Apple Watch (which model is from ECG-enabled regions), this is inconvenient for people whom has Apple Watch from overseas.

Now, you can use this tweak to bypass the cellular network checking.

This tweak is based on [my research](https://hiraku.tw/2019/10/4951/). Moreover, with method swizzling (hook), you don't need to pair Apple Watch again, like the original post for non-jailbroken iPhone.

Appple Watch bought from non-ECG enabled region can't activate ECG with this method.

## Requirement

For iOS 13.5 + watchOS 6.2.5:
Any Apple Watch S4+ can use this tweak to activate ECG.

iOS 13.4.1 + watchOS 6.2.1 or below:
You need Apple Watch S4+ which is bought from [ECG enabled countries / regions](https://www.apple.com/watchos/feature-availability/#branded-ecg).

## Install

ECG Enabler is available on BigBoss repo. Just install it with your favorite package manager.

## Tutorial
1. After the installation, open "ECG" section in the Health.app on your iPhone.
2. Check whether ECG app is installed on your Apple Watch.
3. If it doesn't work, unpair your Apple Watch and pair again.
4. When you re-pair your Apple Watch, choose not to restore backup if your device is bought from [ECG enabled countries / regions](https://www.apple.com/watchos/feature-availability/#branded-ecg). Otherwise, restore the backup.
3. Once ECG is enabled on your Apple Watch, you can remove this tweak.
4. You can restore rootFS / unjailbreak and keep this hack working.
5. If your device is not iOS 13.5 + watchOS 6.2.5, reset all setttings / erase all content and settings / restore var snapshot from your iPhone would make you lose this hack.

## License

MIT. Please kindly keep the credit of contributors.
