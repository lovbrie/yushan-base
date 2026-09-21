#=======================================================
# Agent2D-3.1.0 & librcsc-4.1.0 Makefile
# RoboCup2D @ Anhui Unversity of Technology
# Bugs or Suggestions please mail to guofeng1208@163.com
#=======================================================


config_deps +=  $(patsubst %, $(Dst_Path)/%,    \
                              $(wildcard $(DataPath)/formations-dt/*) )

config_deps +=  $(patsubst %, $(Dst_Path)/%,    \
                              $(wildcard $(DataPath)/*.conf) )

config_deps +=  $(patsubst $(DataPath)/%.tpl, $(Dst_Path)/%.sh,    \
                              $(wildcard $(DataPath)/*.tpl) )



$(Dst_Path)/$(DataPath)/formations-dt/%: $(DataPath)/formations-dt/%
	@test -d $(Dst_Path)/$(DataPath)/formations-dt || \
	mkdir -p $(Dst_Path)/$(DataPath)/formations-dt
	@cp -f $< $@
	@echo ">>> Update  \"$@\""

$(Dst_Path)/%.sh: $(DataPath)/%.tpl config.mk
	@test -d $(Dst_Path) || mkdir -p $(Dst_Path)
	@sed -e 's/@PLAYER@/$(Player_Name)/g' -e 's/@COACH@/$(Coach_Name)/g' "$<" > "$@"
	@chmod +x "$@"
	@echo ">>> Update  \"$@\""

$(Dst_Path)/$(DataPath)/%.conf: $(DataPath)/%.conf
	@test -d $(Dst_Path)/$(DataPath) || mkdir -p $(Dst_Path)/$(DataPath)
	@cp -f $< $@
	@echo ">>> Update  \"$@\""

cleandata:
	@rm -rf $(Dst_Path)/$(DataPath)
	@rm -f $(Dst_Path)/*.sh


#End of Makefile
