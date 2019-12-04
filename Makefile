TWEAK_NAME = ECGEnabler
ECGEnabler_OBJCC_FILES = Tweak.xm
ECGEnabler_CFLAGS = -F$(SYSROOT)/System/Library/CoreServices -fobjc-arc
ECGEnabler_LDFLAGS += HealthKit.tbd
ECGEnabler_FRAMEWORKS = UIKit
TARGET = :clang::11.0
ARCHS = arm64 arm64e
SDKVERSION = 10.2
SYSROOT = $(THEOS)/sdks/iPhoneOS10.2.sdk
ECGEnabler_LDFLAGS += -Wl,-segalign,4000
GO_EASY_ON_ME = 1
FINALPACKAGE = 1

SUBPROJECTS += postinst

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/bundle.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

before-stage::
	rm -f ./layout/DEBIAN/postinst

after-stage::
	mv -f $(THEOS_STAGING_DIR)/tmp/postinst ./layout/DEBIAN/postinst
	rm -Rf $(THEOS_STAGING_DIR)/tmp
	
sync::stage
	rsync -e "ssh -p 2222" -avz .theos/_/Library/MobileSubstrate/DynamicLibraries/* root@127.0.0.1:/Library/MobileSubstrate/DynamicLibraries/
