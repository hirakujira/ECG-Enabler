# ECG Enabler

## Feature

Enable ECG feature for every Apple Watch S4+, regardless of country or region of the device. 

From iOS 12.2, you must connect your iPhone to a cellular network in ECG enabled countries or regions to enable ECG feature of Apple Watch, this is inconvenient for people whom has Apple Watch from overseas. Of course, Apple Watch which bought from non-ECG enabled countries can't use this feature.

Now, with this tweak, bypassing the cellular network and region checking is possible.

This tweak is based on my researches ([1](https://hiraku.tw/2019/10/4951/), [2](https://hiraku.tw/2020/02/6044/)). Moreover, with method swizzling (hook), you don't need to pair Apple Watch again, like the original post for non-jailbroken iPhone.

## Requirement

For iOS 13.5 + watchOS 6.2.5:
Any Apple Watch S4+ can use this tweak to activate ECG.

iOS 13.4.1 + watchOS 6.2.1 or below:
You need Apple Watch S4+ which is bought from [ECG enabled countries and regions](https://www.apple.com/watchos/feature-availability/#branded-ecg).

## Install

ECG Enabler is available on BigBoss repo. Just install it with your favorite package manager.

## Tutorial
1. After the installation, open "ECG" section in the Health.app on your iPhone.
2. Check whether ECG app is installed on your Apple Watch.
3. If it doesn't work, unpair your Apple Watch and pair again.
4. When you re-pair your Apple Watch, choose not to restore backup if your device is bought from [ECG enabled countries / regions](https://www.apple.com/watchos/feature-availability/#branded-ecg). Otherwise, restore the backup.
3. Once ECG is enabled on your Apple Watch, you can remove this tweak.
4. You can restore rootFS / unjailbreak and keep this hack working.
5. If your device is not iOS 13.5 + watchOS 6.2.5, reset all setttings, erase all content and settings or restoring var snapshot from your iPhone would make you lose this hack.

## License

MIT. Please kindly keep the credit of contributors.
