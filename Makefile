all: adb/adbd adbd.service

libcutils/libcutils.a: libcutils/*.c
	pushd libcutils ; make ; popd

adb/adbd: libcutils/libcutils.a adb/*.cpp adb/*.c
	pushd adb ; make ; popd

clean:
	pushd libcutils ; make clean ; popd
	pushd adb ; make clean ; popd
	rm -f adb/adbd libcutils/libcutils.a

install: all
	install -d -m 0755 $(DESTDIR)/$(PREFIX)/sbin
	install -D -m 0755 adb/adbd $(DESTDIR)/$(PREFIX)/sbin/
	install -d -m 0755 $(DESTDIR)/$(PREFIX)/lib/systemd/system/
	install -D -m 0755 adbd.service $(DESTDIR)/$(PREFIX)/lib/systemd/system/
