set root $::env(ROOT)

set_mode setup
read_verilog -sv $root/src/dut/sv/dummy.sv
elaborate
compile

set_mode mv
read_sva \
    $root/src/main/sv/dummy_props.sv
