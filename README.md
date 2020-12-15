# ECG Enabler

## Feature

Enable ECG feature for every Apple Watch S4+, regardless of country or region of the device. 

From iOS 12.2, you must connect your iPhone to a cellular network in ECG enabled countries or regions to enable ECG feature of Apple Watch, this is inconvenient for people whom has Apple Watch from overseas. Of course, Apple Watch which bought from non-ECG enabled countries can't use this feature.

Now, with this tweak, bypassing the cellular network and region checking is possible.

This tweak is based on my researches ([1](https://hiraku.tw/2019/10/4951/), [2](https://hiraku.tw/2020/02/6044/)). Moreover, with method swizzling (hook), you don't need to pair Apple Watch again. (This feature may not work for all devices, if it doesn't work, try to re-pair your Apple Watch)

## Requirement

iOS            | watchOS     | Can use this hack
---------------|-------------|---------------------
12.2 ~ 13.1.1  |5.2 ~ 6.0    |Unknown, maybe works
13.1.2 ~ 13.3.1|6.0.1 ~ 6.1.3|Yes, but Apple Watch must from [ECG enabled region](https://www.apple.com/watchos/feature-availability/#branded-ecg)
13.4 ~ 13.4.1  |6.2 ~ 6.2.1  |No
13.5 ~ 13.7    |6.2.5 ~ 6.2.8|Yes, all regions
14.0 ~ 14.2    |6.2.5 ~ 6.2.8|Yes, all regions
14.0 ~ 14.2    |7.0 ~ 7.0.1  |No
14.0 ~ 14.2    |7.0.2 ~ 7.1  |Yes, all regions
14.3 ~         |7.2 ~        |Yes, all regions. Also supports [ECG algorithm v2](https://developer.apple.com/documentation/healthkit/hkappleecgalgorithmversion/hkappleecgalgorithmversion2?language=objc)

## Install

ECG Enabler is available on BigBoss repo. Just install it with your favorite package manager.

## Tutorial
1. After the installation, open "ECG" section in the Health.app on your iPhone.
2. Check whether ECG app is installed on your Apple Watch.
3. If it doesn't work, unpair your Apple Watch and pair again.
4. When you re-pair your Apple Watch, choose not to restore backup if your device is bought from [ECG enabled countries / regions](https://www.apple.com/watchos/feature-availability/#branded-ecg). Otherwise, restore the backup.
5. Once ECG is enabled on your Apple Watch, you can remove this tweak.
6. You can restore rootFS / unjailbreak and keep this hack working.
7. Upgrade watchOS/iOS versions, reset all setttings, erase all content and settings or restoring var snapshot from your iPhone may make you lose this hack.
8. You may need to reinstall the tweak to upgrade ECG algorithm from v1 to v2. ECG algorithm v2 only supports iOS 14.3 with watchOS 7.2 and above.

## License

MIT. Please kindly keep the credit of contributors.
