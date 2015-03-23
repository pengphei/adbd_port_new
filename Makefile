all: adb/adbd

libcutils/libcutils.a: libcutils/*.c
	pushd libcutils ; make ; popd

adb/adbd: libcutils/libcutils.a adb/*.cpp adb/*.c
	pushd adb ; make ; popd

clean:
	pushd libcutils ; make clean ; popd
	pushd adb ; make clean ; popd
	rm -f adb/adbd libcutils/libcutils.a

install: FIXME
