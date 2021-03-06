CPP:=g++
CFLAGS:=-Wall -Wextra -Wno-literal-suffix -Wno-unused-local-typedefs -Werror -O3 -std=gnu++0x -D_VARIANT_=4
WXLIBS:=$(shell wx-config --libs core,base,adv)
WXFLAGS:=$(shell wx-config --cxxflags)

CORE_OBJS:=core/board.o core/eqs.o core/logbook.o core/perfana.o core/utils.o core/vargroup.o
GUI_OBJS:=gui/bevelctrl.o gui/bitmapctrl.o gui/boardctrl.o gui/buttonctrl.o gui/ctrl.o gui/gamectrl.o gui/lcdctrl.o gui/smileyctrl.o
WX_OBJS:=core/options.o wxwin/api.o wxwin/app.o wxwin/dialogs.o

OBJS:=$(CORE_OBJS) $(GUI_OBJS) $(WX_OBJS)
DEPENDS:=$(OBJS:%.o=%.d)

mines-perfect: $(OBJS)
	$(CPP) -o mines-perfect $(CFLAGS) $(OBJS) $(WXLIBS)

-include $(DEPENDS)

$(CORE_OBJS): %.o: %.cpp
		$(CPP) -MMD -MP -c $(CFLAGS) $< -o $@

$(GUI_OBJS): %.o: %.cpp
		$(CPP) -MMD -MP -c $(CFLAGS) $< -o $@

$(WX_OBJS): %.o: %.cpp
		$(CPP) -MMD -MP -c $(CFLAGS) $(WXFLAGS) $< -o $@

.PHONY: clean

clean:
	rm -f mines-perfect $(OBJS) $(DEPENDS) *~
