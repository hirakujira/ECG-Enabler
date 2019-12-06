ARCHS = arm64 arm64e
GO_EASY_ON_ME := 1

TOOL_NAME = postinst
postinst_FILES = postinst.mm
postinst_FRAMEWORKS = Foundation
postinst_INSTALL_PATH = /tmp
postinst_CODESIGN_FLAGS = -Sentitlements.xml
postinst_CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tool.mk