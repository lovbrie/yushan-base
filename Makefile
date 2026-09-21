#===============================================================
# Agent2D-3.1.0 & librcsc-4.1.0 Makefile
# RoboCup2D @ Anhui Unversity of Technology
# Bugs or Suggestions please mail to yushan2d@gmail.com
# Thanks to Hidehisa AKIYAMA(Copyright)
#===============================================================

include init.mk
include config.mk

first: all

include $(SUBMAKE)

Rcsc_Deps		+=	$(patsubst %.o, %.d, $(Rcsc_Obj))
Player_Deps	+=	$(patsubst %.o, %.d, $(Player_Obj))
Coach_Deps		+=	$(patsubst %.o, %.d, $(Coach_Obj))
Trainer_Deps	+=	$(patsubst %.o, %.d, $(Trainer_Obj))

-include $(Rcsc_Deps)
-include $(Player_Deps)
-include $(Coach_Deps)
-include $(Trainer_Deps)


all: $(config_target) \
				   $(player_target) $(coach_target) $(trainer_target)


$(player_target): $(Rcsc_Obj) $(Rcsc_lib) $(Player_Obj)
	$(CXX) $(LD_PATH) $(LDFLAGS) -o "$@" $(Player_Obj) $(Rcsc_lib) $(LIBS);	\

	@echo ""
	@echo "### Bulid Player success! ###"
	@echo ""


$(coach_target): $(Rcsc_Obj) $(Rcsc_lib) $(Coach_Obj)
	$(CXX) $(LD_PATH) $(LDFLAGS) -o "$@" $(Coach_Obj) $(Rcsc_lib) $(LIBS);	\

	@echo ""
	@echo "### Bulid Coach success! ###"
	@echo ""


$(trainer_target): $(Rcsc_Obj) $(Rcsc_lib) $(Trainer_Obj)
	$(CXX) $(LD_PATH) $(LDFLAGS) -o "$@" $(Trainer_Obj) $(Rcsc_lib) $(LIBS);	\

	@echo ""
	@echo "### Bulid Trainer success! ###"
	@echo ""


$(Rcsc_lib): $(Rcsc_Obj)
	@$(CXX) $(LDFLAGS) $(EXTR_LDFLAGS) -o "$@" $(Rcsc_Obj)
	@mv -f "$@" "$(Dst_Path)/$@"
	@ln -fs "$(Dst_Path)/$@" "$@"

$(config_target): $(config_deps)


clean: cleansrc

distclean cleanall:
	@rm -rf $(Dst_ObjPath) $(Dst_Path) $(Rcsc_lib)
	@echo ""
	@echo "clean finish!"
	@echo ""

cleansrc: cleandata
	@rm -rf $(player_target) $(coach_target) $(trainer_target) $(Dst_SrcObj)
	@rm -rf $(Dst_Path)/$(Rcsc_lib) $(Dst_Path)
	@echo ""
	@echo "clean src finish!"
	@echo ""

.PHONY: all clean distclean cleanall cleansrc cleandata


#End of Makefile
