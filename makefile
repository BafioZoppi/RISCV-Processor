GHDL = ghdl
WORK = work-obj93.cf
CONST = constants.vhd

NAMES_ALU = full_adder adder subtract less_than equals alu
NAMES_MEMORY = ram register instruction_memory program_counter
NAMES_STAGES = fetch exec ram_wb
NAMES_COMPONENTS = comp_1 comp_2
NAMES_PROCESSOR = stall reg_wr ldsd fibonacci hazard_bin

all: constants alu memory tools stages components processor
#	$(GHDL) -a components/bubble_sort.vhd

test: test-alu test-memory test-stages test-components test-processor

run:
	$(GHDL) -r bubble_sort --wave=testbenches/processor/bubble_sort.ghw --stop-time=15000ns

constants:
	$(GHDL) -a $(CONST)

alu:
	$(GHDL) -a alu/alu_lib.vhd
	$(GHDL) -a alu/src/*.vhd
	$(GHDL) -a alu/tb/*.vhd

memory:
	$(GHDL) -a memory/memory.vhd
	$(GHDL) -a memory/src/*.vhd
	$(GHDL) -a memory/tb/*.vhd

tools:
	$(GHDL) -a tools/tools.vhd
	$(GHDL) -a tools/src/*.vhd
	$(GHDL) -a tools/tb/*.vhd

stages:
	$(GHDL) -a stages/records.vhd
	$(GHDL) -a stages/stages.vhd
	$(GHDL) -a stages/src/*.vhd
	$(GHDL) -a stages/tb/*.vhd

components:
	$(GHDL) -a components/comp_lib.vhd
	$(GHDL) -a components/src/*.vhd
	$(GHDL) -a components/tb/*.vhd

processor:
	$(GHDL) -a processor/template.vhd
	$(GHDL) -a processor/tb/*.vhd
	$(GHDL) -a processor/*.vhd

test-alu:
	@for NAME in $(NAMES_ALU); do \
	$(GHDL) -r $${NAME}_testbench --wave=testbenches/alu/$${NAME}.ghw --stop-time=1500ns; \
	done

test-memory:
	@for NAME in $(NAMES_MEMORY); do \
	$(GHDL) -r $${NAME}_testbench --wave=testbenches/memory/$${NAME}.ghw --stop-time=1500ns; \
	done

test-stages:
	@for NAME in $(NAMES_STAGES); do \
	$(GHDL) -r $${NAME}_testbench --wave=testbenches/stages/$${NAME}.ghw --stop-time=1500ns; \
	done

test-components:
	@for NAME in $(NAMES_COMPONENTS); do \
	$(GHDL) -r $${NAME}_testbench --wave=testbenches/components/$${NAME}.ghw --stop-time=1500ns; \
	done

test-processor:
	@for NAME in $(NAMES_PROCESSOR); do \
	$(GHDL) -r $${NAME}_testbench --wave=testbenches/processor/$${NAME}.ghw --stop-time=1500ns; \
	done

clean:
	rm -f testbenches/alu/*.ghw
	rm -f testbenches/components/*.ghw
	rm -f testbenches/memory/*.ghw
	rm -f testbenches/processor/*.ghw
	rm -f testbenches/stages/*ghw
	rm -f $(WORK)

.PHONY: all alu memory main stages components tools processor