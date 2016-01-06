# serial port (router console)
SERIAL_PORT=/dev/ttyUSB0
# enable secret
ENABLE_SECRET=enable

TARGET=powerpc-elf
PREFIX=~/$(TARGET)/bin

GDB=$(PREFIX)/$(TARGET)-gdb

debug:
	# 9600, N, 8, 1
	stty -F $(SERIAL_PORT) cs8 -parenb -crtscts -ixon -clocal -cstopb
	printf '\r\n'>$(SERIAL_PORT)
	sleep 1
	printf 'enable\r\n'>$(SERIAL_PORT)
	sleep 1
	printf '$(ENABLE_SECRET)\r\n'>$(SERIAL_PORT)
	sleep 1
	printf 'gdb kernel\r\n'>$(SERIAL_PORT)
	sleep 1
	$(GDB) -x gdbinit -b 9600

clean:

.PHONY: clean debug
