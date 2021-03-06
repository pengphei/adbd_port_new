# makefile to build adbd natively for linux:

LIBADB_SRC_FILES := \
    adb.cpp \
    adb_auth.cpp \
    adb_io.cpp \
    adb_listeners.cpp \
    sockets.cpp \
    transport.cpp \
    transport_local.cpp \
    transport_usb.cpp

LIBADB_linux_SRC_FILES := \
    fdevent.cpp \
    get_my_path_linux.cpp \

LOCAL_SRC_FILES := \
    $(LIBADB_SRC_FILES) \
    $(LIBADB_linux_SRC_FILES) \
    adb_auth_client.cpp \
    fdevent.cpp

LOCAL_SRC_FILES += \
    adb_main.cpp \
    services.cpp \
    file_sync_service.cpp \
    framebuffer_service.cpp \
    remount_service.cpp \
    set_verity_enable_state_service.cpp

# DISABLED SOURCES for ADB_NON_ANDROID:
#   qemu_tracing.cpp
#   usb_linux.cpp
#   jdwp_service.cpp

LOCAL_SRC_C_FILES := \
	usb_linux_client.c

LOCAL_CFLAGS := -O2 -g -DADB_HOST=0 -Wall -Wno-unused-parameter
LOCAL_CFLAGS += -D_XOPEN_SOURCE -D_GNU_SOURCE -DHAVE_PTHREADS=1
LOCAL_CFLAGS += -DADB_NON_ANDROID=1
LOCAL_CFLAGS += -DPROP_NAME_MAX=32 -DPROP_VALUE_MAX=92
LOCAL_INCLUDES := -I../include -I.

LOCAL_MODULE := adbd

LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT_SBIN)
LOCAL_UNSTRIPPED_PATH := $(TARGET_ROOT_OUT_SBIN_UNSTRIPPED)

LOCAL_STATIC_LIBRARIES := libcutils libc

################################

OBJS = $(LOCAL_SRC_FILES:.cpp=.o) $(LOCAL_SRC_C_FILES:.c=.o)
CXXFLAGS = -std=c++0x $(LOCAL_CFLAGS) $(LOCAL_INCLUDES)
CFLAGS= $(LOCAL_CFLAGS) $(LOCAL_INCLUDES)

%.o: %.cpp
	g++ -g -c -fPIC $(CXXFLAGS) $(LFLAGS) $< -o $@

%.o: %.c
	echo $(OBJS)
	gcc -g -c -fPIC $(CFLAGS) $(LFLAGS) $< -o $@

$(LOCAL_MODULE): $(OBJS)
	g++ -fPIC $(CXXFLAGS) $^ -L ../libcutils/*.o -lpthread -lresolv -lcrypto -lssl -o $@

clean:
	rm -f $(LOCAL_MODULES) *.o

