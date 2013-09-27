EMPTY=
SPACE=$(EMPTY) $(EMPTY)

define DEF_SUBMODULE_RUSTPKG_RULES

$$(DONE_$(1)) : $(1)

$(1) :
	$$(Q) \
	RUST_PATH=$(CFG_BUILD_HOME)workspace:$(subst $(SPACE),:,$(foreach submodule,$(strip $(CFG_SUBMODULES_RUSTPKG)),$(S)src/$(submodule))) \
	$(CFG_RUSTPKG) --rust-path-hack install $(1)

.PHONY : $(1)

endef

