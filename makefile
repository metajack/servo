# Pastebin Q1TlfJZa
.PHONY: all touch clean measure

DATE=$(shell date '+%Y-%m-%d')

all:
	echo "try `make measure` etc"

measure:
	@for N in clean all@000-dev all@010-dev-incr all@020-dev-touch-style all@030-dev-add-method all@040-dev-change-script-layout-fn-body; \
	do echo ${DATE}: running '`'make $$N'`' ; \
	make CARGO_RUSTC_OPTS=-Ztime-passes $$N > measurements.${DATE}.$$N 2>&1 ; \
	tail -1 measurements.${DATE}.$$N ; \
	done

all@000-dev:
	./mach cargo -- rustc -p script $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS)

all@010-dev-incr:
	RUSTFLAGS="-Zincremental=${PWD}/incr" \
		./mach cargo -- rustc -p script $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS) -Zincremental-info

all@020-dev-touch-style:
	touch components/style/lib.rs
	RUSTFLAGS="-Zincremental=${PWD}/incr" \
		./mach cargo -- rustc -p script $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS) -Zincremental-info

# Try to measure the effect of a realistic change.
all@030-dev-add-method:
	patch -p1 < add_method_to_properties.diff
	RUSTFLAGS="-Zincremental=${PWD}/incr" \
		./mach cargo -- rustc -p script $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS) -Zincremental-info

# Try to measure the effect of a realistic change.
all@040-dev-change-script-layout-fn-body:
	patch -p1 < change_script_layout_interface_fn_body.diff
	RUSTFLAGS="-Zincremental=${PWD}/incr" \
		./mach cargo -- rustc -p script $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS) -Zincremental-info

measure-cc:
	@for N in clean all@000-dev all@010-dev-incr-cc all@020-dev-touch-style-cc all@030-dev-add-method-cc all@040-dev-change-script-layout-fn-body-cc; \
	do echo ${DATE}: running '`'make $$N'`' ; \
	make CARGO_RUSTC_OPTS=-Ztime-passes $$N > measurements.${DATE}.cc.$$N 2>&1 ; \
	tail -1 measurements.${DATE}.cc.$$N ; \
	done

all@010-dev-incr-cc:
	RUSTFLAGS="-Zincremental=${PWD}/incr -Zincremental-cc" \
		./mach cargo -- rustc -p script $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS) -Zincremental-info

all@020-dev-touch-style-cc:
	touch components/style/lib.rs
	RUSTFLAGS="-Zincremental=${PWD}/incr -Zincremental-cc" \
		./mach cargo -- rustc -p script $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS) -Zincremental-info

# Try to measure the effect of a realistic change.
all@030-dev-add-method-cc:
	patch -p1 < add_method_to_properties.diff
	RUSTFLAGS="-Zincremental=${PWD}/incr -Zincremental-cc" \
		./mach cargo -- rustc -p script $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS) -Zincremental-info

# Try to measure the effect of a realistic change.
all@040-dev-change-script-layout-fn-body-cc:
	patch -p1 < change_script_layout_interface_fn_body.diff
	RUSTFLAGS="-Zincremental=${PWD}/incr -Zincremental-cc" \
		./mach cargo -- rustc -p script $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS) -Zincremental-info

# measure typical debugging by println case
all@050-add-println-to-script-event-loop:
	patch -p1 < add_println_to_script_event_loop.diff
	RUSTFLAGS="-Zincremental=${PWD}/incr -Zincremental-cc" \
		./mach cargo -- rustc -p script $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS) -Zincremental-info

touch:
	find . -name '*orig' -delete
	find . -name '*pyc' -delete
	git checkout components
	rm -rf incr
	./mach cargo -- clean -p script

clean: touch
	./mach clean

patches:
	@echo \
		"@000-dev" \
		"@010-dev-incr" \
		"@020-dev-touch-style" \
		"@030-dev-add-method" \
		"@040-dev-change-script-layout-fn-body" \
		"@050-dev-add-println-to-script-event-loop"
