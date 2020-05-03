##
## This file is part of the libopencm3 project.
##
## Copyright (C) 2009 Uwe Hermann <uwe@hermann-uwe.de>
##
## This library is free software: you can redistribute it and/or modify
## it under the terms of the GNU Lesser General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This library is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU Lesser General Public License for more details.
##
## You should have received a copy of the GNU Lesser General Public License
## along with this library.  If not, see <http://www.gnu.org/licenses/>.
##

OBJS = util.o dump.o sdio.o sdio_util.o debug.o uart.o clock.o term.o rtos/heap_4.o rtos/list.o rtos/port.o rtos/tasks.o
BINARY = monitor
V = 1

TGT_CFLAGS	+= -I./rtos -I.
TGT_CXXFLAGS	+= -I./rtos -I.

LDSCRIPT = ./stm32f407vet6.ld

include ../../Makefile.include

GDB_CONNECT = -ex 'target extended-remote /dev/ttyBmpGdb' -ex 'monitor swdp_scan' -ex 'atta 1'
GDB_SVD = -ex 'source ~/STM32/gdb.py' -ex 'svd_load ~/STM32/STM32F401x.svd'

fl: $(BINARY).elf
	$(GDB) --batch $(GDB_CONNECT) -ex load  $^

dbg: $(BINARY).elf
	$(GDB)-py $(GDB_CONNECT) $(GDB_SVD) $^


fldbg: $(BINARY).elf
	$(GDB)-py $(GDB_CONNECT) $(GDB_SVD) -ex load $^
